int plus(int a, int b) {
  return a+b;
}

int repeat(int (*intop)(int,int), int times, int operand) {
  int tmp = 0;
  for (int i=0;i<times;i++) {
    tmp = intop(operand, tmp);
  }
  return tmp;
}

int main() {
  int x=5;
  int result;
  result = repeat(plus, 10, 6);

  return 0;
}
