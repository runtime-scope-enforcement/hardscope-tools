void a(char *buf) {
  char *a = buf;
  buf[10] = 0xff;
  a--;
  a[0] = 0xff;
}

int main() {
  int i = 123;
  char mybuf[10];
  int j = 456;
  a(mybuf);
  return 0;
}
