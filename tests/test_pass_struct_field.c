struct test {
  char* name;
  int value;
};

int good_value(int *v) {
  return *v>10;
}

int main() {
  struct test t = {"anon_string", 9};

  good_value(&t.value);

  return 0;
}
