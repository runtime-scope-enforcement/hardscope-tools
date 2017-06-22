int num;

void inc_address() {
  int *a = &num;
  (*a)++;
}

int main() {
  inc_address();
  return 0;
}
