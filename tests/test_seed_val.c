typedef signed int ee_s32;

extern volatile ee_s32 seed1_volatile;
extern volatile ee_s32 seed2_volatile;
extern volatile ee_s32 seed3_volatile;
extern volatile ee_s32 seed4_volatile;
extern volatile ee_s32 seed5_volatile;

ee_s32 get_seed_32(int i) {
  ee_s32 retval;
  switch (i) {
    case 1:
      retval=seed1_volatile;
      break;
    case 2:
      retval=seed2_volatile;
      break;
    case 3:
      retval=seed3_volatile;
      break;
    case 4:
      retval=seed4_volatile;
      break;
    case 5:
      retval=seed5_volatile;
      break;
    default:
      retval=0;
      break;
  }
  return retval;
}

int main() {
  get_seed_32(1);
  get_seed_32(2);
  get_seed_32(3);
  get_seed_32(4);
  get_seed_32(5);
  get_seed_32(6);
  return 0;
}
