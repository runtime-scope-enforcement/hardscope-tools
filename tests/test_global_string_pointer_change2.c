static unsigned char *x = "a string";
char strbuf[100];

void change(unsigned char *c) {
  *c |= 0x20;
}

void copy(char *d, char *s) {
  int i = 0;
  while (s[i]) {
    d[i] = s[i];
    i++;
  } 
  d[i] = s[i];
}

void change_ptr(char **p) {
  *p = "c string";
}

int main () {
  x = "b string";
  copy(strbuf, x);
  change_ptr(&x);
  copy(strbuf, x);
  return 0;
}
