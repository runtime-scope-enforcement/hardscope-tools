#include <stdio.h>

int *find(int *a, int val, int n) {
  for (int i=0;i<n;i++) {
    if (a[i] == val) {
      return &a[i];
    }
  }

  return (void*)0;
}

void find_wrapper(int *a, int val, int n, int** res) {
  find(a, val, n);
}

int main() {
  int a[200];
  int *res;
  for (int i=0;i<sizeof(a)/sizeof(a[0]);i++) {
    a[i] = i*i;
  }

  for (int i=0;i<2000;i++) {
    find_wrapper(a, i, sizeof(a)/sizeof(a[0]), &res);
  }

  return 0;
}
