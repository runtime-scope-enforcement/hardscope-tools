#include <stdarg.h>

int qprint(va_list va) {
  register char *s = va_arg(va, char*);
  return (int) *s;
}

int printf(int x, ...)
{
  int pc;
  va_list va;

  va_start(va, x);

  pc = qprint(va);

  va_end(va);

  return pc;
}

int main(){
  printf(0, "Something\n");
  return 0;
}
