typedef unsigned char ee_u8;
static ee_u8 *intpat[4]  ={(ee_u8 *)"5012",(ee_u8 *)"1234",(ee_u8 *)"-874",(ee_u8 *)"+122"};

int main() {
  short seed = 1;
  int next;
  ee_u8 *buf=0;
  switch (seed & 0x7) {
    case 0: /* int */
    case 1: /* int */
    case 2: /* int */
      buf=intpat[(seed>>3) & 0x3];
      next=4;
      break;
    default:
      break;
  }
  char my;
  if (buf) {
    my = buf[0];
  }
  return 0;
}
