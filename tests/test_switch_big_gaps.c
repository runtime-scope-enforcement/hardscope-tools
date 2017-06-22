static char *letters = "abcdefghijklmnopqrstuvwxyz";

int value(char i) {
  int retval;
  switch (i) {
    case 'a':
      retval=8;
      break;
    case 'x':
      retval=letters[6];
      break;
    case 'S':
      retval=letters[9];
      break;
    case 9:
      retval=letters[8];
      break;
    case '1':
      retval=letters[2];
      break;
    case '\n':
      retval=letters[5];
      break;
    case 3:
      retval=letters[1];
      break;
    default:
      retval=0;
      break;
  }

  return retval;
}

int main() {
  value('a');
  value('x');
  value(254);
  value(0);
  return 0;
}
