struct user {
  char *name;
  int id;
  char hash[4];
};

void make_user(struct user *u) {
  u->name = "bob";
  u->id = 99;
}

void help1() {
  struct user admin;
  make_user(&admin);
}

//fill the stack with something other than 0
void stack_filler() {
  char a[124];
  for (int i=0; i<sizeof(a); i++) {
    a[i]='0';
  }
}

int main() {
  stack_filler();
  help1();

  return 0;
}


