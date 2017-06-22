char a[] = {
' ',' ','H','E','L','L','O','!', 0,
};

char *get() {
  return a;
}

int main() {
  char *d = get();
  int x = 0;
  while (*d) {
    if (*d > 'A' && *d < 'Z') {
      x++;
    }
    d++;
  }
  //unused();
  return 0;
}
