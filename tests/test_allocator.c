char buf[100];

void *allocator() {
  static int i = 0;
  void *p = buf + i;
  i+=10;
  return p;
}

int main() {
  char *data;
  data = allocator();
  data[0] = 'a';
  data = allocator();
  data[9] = 'a';
  return 0;
}
