int test(int *x) {
  return *x > 0;
}

int main() {
  int x[10] = {1,2,3,4,5,6,7,8,9,0};
  test(&x[2]);
  return 0;
}
