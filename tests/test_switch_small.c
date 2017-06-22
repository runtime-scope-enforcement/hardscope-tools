int value(int j) {
  int retval = 2;
  switch (j) {
    case 1:
      retval=retval*retval;
      break;
    case 2:
      retval=retval*retval*retval;
      break;
    default:
      retval=1;
      break;
  }
  return retval;
}

int main() {
  value(1);
  value(0);
  value(5);
  return 0;
}
