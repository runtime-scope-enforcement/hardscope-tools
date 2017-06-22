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
struct GTY(())  riscv_frame_info {
  /* The size of the frame in bytes.  */
  HOST_WIDE_INT total_size;

  /* Bit X is set if the function saves or restores GPR X.  */
  unsigned int mask;

  /* Likewise FPR X.  */
  unsigned int fmask;

  /* How much the GPR save/restore routines adjust sp (or 0 if unused).  */
  unsigned save_libcall_adjustment;

  /* Offsets of fixed-point and floating-point save areas from frame bottom */
  HOST_WIDE_INT gp_sp_offset;
  HOST_WIDE_INT fp_sp_offset;

  /* Offset of virtual frame pointer from stack pointer/frame bottom */
  HOST_WIDE_INT frame_pointer_offset;

  /* Offset of hard frame pointer from stack pointer/frame bottom */
  HOST_WIDE_INT hard_frame_pointer_offset;

  /* The offset of arg_pointer_rtx from the bottom of the frame.  */
  HOST_WIDE_INT arg_pointer_offset;
};

#define XSCEN_MAX_FIELDS 16
struct xscen_delegation {
  unsigned int pointer_depth;
  unsigned int struct_pointers;
  unsigned int offsets[XSCEN_MAX_FIELDS];
  bool subregion;
  HOST_WIDE_INT subsize;
};

struct GTY(())  machine_function {
  /* The number of extra stack bytes taken up by register varargs.
     This area is allocated by the callee at the very top of the frame.  */
  int varargs_size;

  /* Memoized return value of leaf_function_p.  <0 if false, >0 if true.  */
  int is_leaf;

  /* The current frame information, calculated by riscv_compute_frame_info.  */
  struct riscv_frame_info frame;

  int returns_pointer;
  int return_register;
  int allocator;
  struct xscen_delegation return_fields;
  int global_count;
#define XSCEN_MAX_GLOBALS 64
  tree globals[XSCEN_MAX_GLOBALS];
  HOST_WIDE_INT global_sizes[XSCEN_MAX_GLOBALS];

#define XSCEN_MAX_CALLEES 64
#define XSCEN_MAX_ARGS 32
  int total_callees;
  tree callees[XSCEN_MAX_CALLEES];
  unsigned int callee_uids[XSCEN_MAX_CALLEES];
  struct xscen_delegation* callee_pointer_args[XSCEN_MAX_CALLEES][XSCEN_MAX_ARGS];
  unsigned int unknown_callee;

#define XSCEN_MAX_SWITCHES 64
  rtx jumptables[XSCEN_MAX_SWITCHES];
  unsigned jtcount;

};

