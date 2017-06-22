#include <stdarg.h>

void many(int n, ...) {
  va_list ap;
  int total = 0;
  va_start(ap, n);
  for (;n;n--) {
    total += va_arg(ap, int);
  }
}

int main() {
  many(1);
  return 0;
}
