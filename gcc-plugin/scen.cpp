/*
 *   Copyright (c) 2018 Aalto University, Secure Systems Group
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the Gnu General Public License as published by
 * the Free Software Foundation, either version 3 of the license, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but without any warranty; without even the implied warranty of
 * merchantability or fitness for a particular purpose. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the gnu general public license
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */ 
#include <gcc-plugin.h>
#include <tree-pass.h>
#include <tree.h>
#include <rtl.h>
#include <emit-rtl.h>
#include <gimple.h>
#include <gimple-iterator.h>
#include <tree-ssa-operands.h>
#include <tree-phinodes.h>
#include <gimple-ssa.h>
#include <iostream>
#include <ssa-iterators.h>
#include <gimple-pretty-print.h>
#include <tree-pretty-print.h>
#include <diagnostic.h>
#include <langhooks.h>
#include "plugin-version.h"

#include <unordered_map>
#include <unordered_set>
#include <vector>

#include "scen.h"

int plugin_is_GPL_compatible = 1;

static struct plugin_info scenplugin_info =
{
  .version = "1",
  .help = "You are on your own",
};

static struct plugin_gcc_version scenplugin_ver =
{
  .basever = "6.1.0"
};


namespace {
  static tree add_fun_var (tree *tp, int *walk_subtrees, void *data);
  const pass_data testpass_data =
  {
    .type = GIMPLE_PASS,
    .name = "scen-testpass",
    .optinfo_flags = OPTGROUP_NONE,
    .tv_id = TV_NONE,
    .properties_required = PROP_gimple_any,
    .properties_provided = 0,
    .properties_destroyed = 0,
    .todo_flags_start = 0,
    .todo_flags_finish = 0,
  };

  struct testpass : gimple_opt_pass
  {
    testpass(gcc::context *ctx) :
      gimple_opt_pass(testpass_data, ctx)
    {
    }

    virtual unsigned int execute(function *fun) {
      std::cout << "gimple testpass: called execute " << function_name(fun) << "\n" << std::flush;
      iterate_gimple_references();
      iterate_calls();
      returns_pointer();
      std::cout << "gimple testpass: execute finished for function " << function_name(fun) << "\n" << std::flush;
      return 0;
    }

    bool is_memory_allocator(function *f) {
      return (strstr(function_name(f), "malloc") != NULL);
    }

    void returns_pointer() {
      tree res = DECL_RESULT(cfun->decl);
      if (TREE_CODE(res) != RESULT_DECL) {
        gcc_unreachable();
      }
      tree type = TREE_TYPE(res);
      if (!POINTER_TYPE_P(type)) return;
      if (FUNCTION_POINTER_TYPE_P(type)) return;
      cfun->machine->returns_pointer = 1;
      cfun->machine->allocator = is_memory_allocator(cfun);
      new_deleg_struct(res, &cfun->machine->return_fields);
    }

    void iterate_calls() {
      basic_block bb;
      unsigned fakeuid = 1;
      unsigned i = 0;
      FOR_EACH_BB_FN (bb, cfun)
      {
        //gimple_bb_info *bb_info = &bb->il.gimple;
        //print_gimple_seq(stdout, bb_info->seq, 0, 0);
        gimple_stmt_iterator gsi;
        for (gsi = gsi_start_bb (bb); !gsi_end_p (gsi); gsi_next (&gsi))
        {
          gimple *stmt = gsi_stmt (gsi);

          if (is_gimple_call (stmt)) {
            struct xscen_delegation **refvec = cfun->machine->callee_pointer_args[i];
            ref_args_gimple(stmt, refvec);
            unsigned uid = 0;
            tree callt = gimple_call_fn(stmt);
            //print_gimple_stmt(stdout, stmt, 0, 0);
            tree callee;
            if (!callt) continue;
            if (TREE_CODE(callt) == ADDR_EXPR && TREE_CODE(TREE_OPERAND(callt, 0)) == FUNCTION_DECL) {
              callee = TREE_OPERAND(callt, 0);
              gcc_assert(callee);
              uid = DECL_UID(FUNCTION_DECL_CHECK(callee));
              //TODO: evaluate possibility of getting the tree instead of uid and use it as identifier at expand
            } else if (TREE_CODE(callt) == SSA_NAME) {
              uid = fakeuid++;
            } else {
              gcc_unreachable();
            }
            cfun->machine->callees[i] = callt;
            cfun->machine->callee_uids[i] = uid;
            i++;
            gcc_assert(i<=XSCEN_MAX_CALLEES);
          }
        }
      }
      cfun->machine->total_callees = i;
    }

    unsigned int arg_pointer(tree arg) {
      //TODO: there is probably some simpler and more general way
      //this approach checks the actual gimple statements used as
      //args instead of function prototype which is not optimal
      unsigned i = 0;
      tree type = TREE_TYPE (arg);
      while (POINTER_TYPE_P(type) && !FUNCTION_POINTER_TYPE_P(type)) {
        i++;
        type = TREE_TYPE (type);
      }
      return i;
    }

    unsigned int is_array_global(tree t) {
      if (TREE_CODE(t) == COMPONENT_REF || TREE_CODE(t) == ARRAY_REF) {
        t = TREE_OPERAND(t, 0);
        if (TREE_CODE(t) == VAR_DECL) {
          return is_global_var(t);
        }
        return is_array_global(t);
      }
      return 0;
    }

    unsigned int nonglobal_arg(tree arg) {
      tree t;
      tree type = TREE_TYPE (arg);
      if (!POINTER_TYPE_P(type)) return 0;
      if (TREE_CODE (arg) != ADDR_EXPR) return 0;
      t = TREE_OPERAND(arg, 0);

      if (TREE_CODE(t) == COMPONENT_REF || TREE_CODE(t) == ARRAY_REF) {
        return !is_array_global(t);
      }
      if (is_global_var(t)) return 0;
      return 1;
    }

    HOST_WIDE_INT var_size (tree t) {
      if (TREE_CODE(t) == STRING_CST) {
        return TREE_STRING_LENGTH(t);
      }
      if (TREE_CODE(t) == ADDR_EXPR) {
        t = TREE_OPERAND(t, 0);
      }
      if (TREE_CODE(t) == ARRAY_REF) {
        //size of whole array is what interests here
        std::cout << get_tree_code_name(TREE_CODE(t)) << "\n";
        t = TREE_OPERAND(t, 0);
      }
      if (TREE_CODE(t) == COMPONENT_REF) {
        t = TREE_OPERAND(t, 1);
      }
      if (DECL_P(t)) {
        return int_size_in_bytes (TREE_TYPE (t));
      }
      if (TREE_CODE(t) == STRING_CST) {
        return TREE_STRING_LENGTH(t);
      }

      std::cout << get_tree_code_name(TREE_CODE(t)) << "\n";

      gcc_unreachable();
      return 0;
    }

    struct xscen_delegation *new_deleg_struct(tree arg, struct xscen_delegation *d) {
      struct xscen_delegation *o = NULL;
      unsigned j = 0;
      unsigned int p;
      unsigned int stack;
      if (d) {
        o = d;
      } else {
        o = (struct xscen_delegation*) ggc_internal_alloc(sizeof(struct xscen_delegation));
      }
      
      stack = nonglobal_arg(arg);
      p = arg_pointer(arg);

      o->pointer_depth = p;
      o->struct_pointers = 0;
      o->subsize = 0;
      o->subregion = 0;

      if (stack) {
        debug_generic_expr(arg);
        o->subsize = var_size(arg);
        o->subregion = 1;
      }

      if (!p) return o;
      if (TREE_CODE(arg) == INTEGER_CST && TREE_INT_CST_LOW(arg) == 0) return o;

      tree type = TREE_TYPE(TREE_TYPE(arg));

      if (TREE_CODE(type) ==  RECORD_TYPE) {
        tree field = TYPE_FIELDS(type);
        while (field) {
          unsigned int offset = TREE_INT_CST_LOW(DECL_FIELD_OFFSET(field)) + TREE_INT_CST_LOW(DECL_FIELD_BIT_OFFSET(field))/8;
          if (POINTER_TYPE_P(TREE_TYPE(field))) {
            o->offsets[j] = offset;
            j++;
            gcc_assert(j<=XSCEN_MAX_FIELDS);
          }
          field = TREE_CHAIN(field);
        }
      }

      o->struct_pointers = j;

      return o;
    }

    void ref_args_gimple(gimple* call, struct xscen_delegation** refvec) {
      unsigned argcnt = gimple_call_num_args(call);
      for (unsigned i=0; i<argcnt; i++) {
        tree arg = gimple_call_arg(call, i);
        //debug_generic_expr(arg);
        refvec[i] = new_deleg_struct(arg, NULL);
      }
    }

    void iterate_gimple_references() {
      gcc_assert(cfun && cfun->machine);
      cfun->machine->globals[0] = NULL_TREE;
      cfun->machine->global_count = 0;
      basic_block bb;

      int fun_start_set = 0;
      gimple_stmt_iterator gsi_fun_start;

      FOR_EACH_BB_FN (bb, cfun)
      {
        gimple_stmt_iterator gsi;
        size_t i;
        if (!fun_start_set) {
          fun_start_set = 1;
          gsi_fun_start = gsi_start_bb(bb);
        }

        /* Walk the statements.  */
        for (gsi = gsi_start_bb (bb); !gsi_end_p (gsi); gsi_next (&gsi))
        {
          gimple *stmt = gsi_stmt (gsi);

          if (is_gimple_debug (stmt))
            continue;

          if (gimple_clobber_p (stmt))
          {
            continue;
          }

          for (i = 0; i < gimple_num_ops (stmt); i++) {
            tree *v = gimple_op_ptr (gsi_stmt (gsi), i);
            walk_tree (v, add_fun_var, NULL, NULL);
          }
        }
      }
    }
  };

  static void add_global(tree t, HOST_WIDE_INT size) {
    int j = cfun->machine->global_count;
    for (int i = j-1; i>=0; i--) {
      if (cfun->machine->globals[i] == t) {
        return;
      }
    }
    cfun->machine->globals[j] = t;
    cfun->machine->global_sizes[j] = size;
    cfun->machine->global_count++;
    gcc_assert(cfun->machine->global_count <= XSCEN_MAX_GLOBALS);
  }

  static void add_string_cst_global(tree t) {
    gcc_assert(TREE_CODE(t) == STRING_CST);
    add_global(t, TREE_STRING_LENGTH(t));
  }

  static void handle_constructor(tree t) {
    tree v;
    unsigned i;
    FOR_EACH_CONSTRUCTOR_VALUE (CONSTRUCTOR_ELTS(t), i, v) {
      if (TREE_CODE (v) == ADDR_EXPR) {
        v = TREE_OPERAND(v, 0);
        if (TREE_CODE(v) == STRING_CST) {
          add_string_cst_global(v);
        }
      }
    }
  }

  static tree get_initial_decl(tree t) {
    tree d = NULL;
    if (TREE_CODE(t) != VAR_DECL) {
      return NULL;
    }
    d = DECL_INITIAL(t);
    if (!d) {
      return NULL;
    }
    return d;
  }

  static tree add_fun_var (tree *tp, int *walk_subtrees, void *data) {
    tree t = *tp;
    //debug_generic_expr(t);

    if (TREE_CODE (t) == ARRAY_REF) {
      t = TREE_OPERAND(t, 0);
      tree d = get_initial_decl(t);
      if (d && TREE_CODE(d) == CONSTRUCTOR) {
        handle_constructor(d);
      }
    }

    if (TREE_CODE (t) == ADDR_EXPR) {
      *walk_subtrees = 0;
      t = TREE_OPERAND(t, 0);
    }

    if (TREE_CODE(t) == COMPONENT_REF) {
      t = TREE_OPERAND(t, 0);
    }

    if (TREE_CODE(t) == STRING_CST) {
      *walk_subtrees = 0;
      add_string_cst_global(t);
      return NULL;
    }

    if (TREE_CODE (t) == SSA_NAME)
    {
      gimple *def = SSA_NAME_DEF_STMT(t);
      //if def is found and it's assign
      if (def && gimple_code(def)==GIMPLE_ASSIGN) {
        //get the rhs
        tree a = gimple_assign_rhs1(def);
        a = get_initial_decl(a);
        //and check if its var_decl with a decl_initial
        if (a && TREE_CODE(a) == ADDR_EXPR) {
          a = TREE_OPERAND(a, 0);
          //for now we only handle string constants
          if (TREE_CODE(a) == STRING_CST) {
            add_string_cst_global(a);
            return NULL;
          }
        }
      }
      *walk_subtrees = 0;
      t = SSA_NAME_VAR (t);
      if (!t)
        return NULL;
    }

    enum tree_code_class c = TREE_CODE_CLASS (TREE_CODE (t));
    if (IS_EXPR_CODE_CLASS (c))
    {
      *walk_subtrees = 0;
      return NULL;
    }

    if (IS_TYPE_OR_DECL_P (t))
      *walk_subtrees = 0;

    if (TREE_CODE (t) == VAR_DECL) {
      *walk_subtrees = 0;
      if (is_global_var(t)) {
        HOST_WIDE_INT size;
        size = int_size_in_bytes (TREE_TYPE (t));
        add_global(t, size);
      }
    }
    return NULL;
  }
};

int plugin_init(struct plugin_name_args *plugin_info, struct plugin_gcc_version *ver) {
  if (strcmp(scenplugin_ver.basever, gcc_version.basever))
    return 1;
  register_callback(plugin_info->base_name, PLUGIN_INFO, NULL, &scenplugin_info);
  struct register_pass_info pass_info;

  pass_info.pass = new testpass(0);
  pass_info.reference_pass_name = "ssa";
  pass_info.ref_pass_instance_number = 1;
  pass_info.pos_op = PASS_POS_INSERT_AFTER;
  register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP, NULL, &pass_info);

  std::cout << "scen GCC plugin initialized\n" << std::flush;
  return 0;
}
