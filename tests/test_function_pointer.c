int plus(int a, int b) {
  return a+b;
}

int minus(int* a, int* b) {
  return *a+*b;
}

int y=6;
int (*intoperator2)(int, int);

int main() {
  int (*intoperator)(int, int);
  int (*intptroperator)(int*, int*);
  int result;
  int x = 5;

  intoperator = plus;
  x=5;
  result = intoperator(x, 6);
  intptroperator = minus;
  x=5;
  result = intptroperator(&y, &x);
  //intoperator2(6, 5);

  return 0;
}
