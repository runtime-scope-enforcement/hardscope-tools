struct test {
  char* name;
  int value;
};

int good_value(int *v) {
  return *v>10;
}

struct test t = {"anon_string", 9};
int main() {
  good_value(&t.value);

  return 0;
}
