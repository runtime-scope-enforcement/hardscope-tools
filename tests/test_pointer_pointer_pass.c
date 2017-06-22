void set5(int **x) {
  int *a = *x;
  *a = 5;
}

int main() {
  int my;
  int *myp = &my;
  set5(&myp);

}
