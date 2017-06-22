char *unused() {
  return "unused";
}

int alph_count(const char *d) {
  int x = 0;
  while (*d) {
    if (*d > 'A' && *d < 'Z') {
      x++;
    }
    d++;
  }
  //unused();
  return x;
}

int main() {
  char buf[100];
  int count;
  buf[0] = 'h';
  buf[1] = 'A';
  buf[2] = 'K';
  buf[3] = '5';
  buf[4] = '\0';

  count = alph_count(buf);

  return 0;
}
