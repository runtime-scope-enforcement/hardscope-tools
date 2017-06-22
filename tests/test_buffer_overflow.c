void overflow(int n) {
  unsigned char data[123];
  for (register int i=0;i<n;i++) {
  //for (int i=n;i>=0;i--) {
    //asm("srdlg t0");
    data[i] = 1;
  }
}

int main() {
  overflow(300);
  return 0;
}
