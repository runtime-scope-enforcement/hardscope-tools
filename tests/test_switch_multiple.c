int value(int i, int j) {
  char *letters = "abcdefghijklmnopqrstuvxyz";
  int retval;
  switch (i) {
    case 1:
      retval=8;
      break;
    case 8:
      retval=letters[6];
      break;
    case 2:
      retval=letters[9];
      break;
    case 6:
      retval=letters[8];
      break;
    default:
      retval=0;
      break;
  }

  switch (j) {
    case 0:
      retval=-retval;
      break;
    case 1:
      retval=retval;
      break;
    case 8:
      retval=retval*2;
      break;
    case 7:
      retval=retval*2;
      break;
    case 2:
      retval=retval*2;
      break;
    default:
      retval=0;
      break;
  }
  return retval;
}

int main() {
  value(6, 4);
  value(1, 2);
  value(9, 0);
  value(8, 0);
  value(2, 2);
  return 0;
}
