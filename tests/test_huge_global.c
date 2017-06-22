//this is huge enough not to be a SMALL_OPERAND on RISC-V
char huge[3072];

int main() {
  huge[0] = 'a';
  huge[sizeof(huge)-1] = 'a';
  return 0;
}
