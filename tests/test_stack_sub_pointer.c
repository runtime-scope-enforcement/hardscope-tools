void a(char *buf) {
  char *a = buf;
  buf[10] = 0xff;
  a--;
  a[0] = 0xff;
}

int main() {
  char *off;
  int i = 123;
  char mybuf[10];
  int j = 456;
  off = mybuf;
  a(off);
  return 0;
}
