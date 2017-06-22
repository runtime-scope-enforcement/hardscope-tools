void big_stack() {
  char stack[2048];
  for (register int i=0;i<sizeof(stack);i++)
    stack[i]='A';
}

int main() {
  big_stack();
  return 0;
}
