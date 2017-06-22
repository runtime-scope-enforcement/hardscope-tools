void huge_stack() {
  char stack[4096];
  for (register int i=0;i<sizeof(stack);i++)
    stack[i]='A';
}

int main() {
  huge_stack();
  return 0;
}
