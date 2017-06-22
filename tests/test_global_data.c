static unsigned char *x = "a string";
char strbuf[100] = {'t', 'e', 's', 't', 't', 0};

void change(unsigned char *c) {
  *c |= 0x20;
}

void stringwrangler() {
  char *s = strbuf;
  while (*s) {
    change(s);
    s++;
  }
}

int main () {
  stringwrangler();
  return 0;
}
