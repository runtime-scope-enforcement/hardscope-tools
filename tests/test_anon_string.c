int count(const char *str, char c) {
  int i = 0;
  int n = 0;
  while (str[i]) {
    if (str[i]==c) {
      n++;
    }
    i++;
  }
}

int main() {
  int x;
  x = count("makkara", 'a');
  x = count("makkara", 'a');
  return 0;
}
