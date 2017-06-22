#include <stdio.h>

int *find(int *a, int val, int n) {
  for (int i=0;i<n;i++) {
    if (a[i] == val) {
      return &a[i];
    }
  }

  return (void*)0;
}

int main() {
  int a[200];
  for (int i=0;i<sizeof(a)/sizeof(a[0]);i++) {
    a[i] = i*i;
  }

  for (int i=0;i<2000;i++) {
    find(a, i, sizeof(a)/sizeof(a[0]));
  }

  return 0;
}
