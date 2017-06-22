void aa() {
  
}

void cc() {}

void bb() {
  cc();
  cc();
}

int main() {
  aa();
  aa();

  bb();
  aa();
  bb();
  cc();

  return 0;
}
