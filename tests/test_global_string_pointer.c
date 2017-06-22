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

int main () {
  copy(strbuf, x);
  return 0;
}
