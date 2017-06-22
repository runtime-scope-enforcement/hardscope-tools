int printf(const char *format, ...);
int putchar(int s);

typedef struct RESULTS_S {
  int crclist;
} core_results;

static core_results results[] = {{1111}, {222}, {9891}};
static unsigned short list_known_crc[] = {(unsigned short)0xd4b0,(unsigned short)0x3340,(unsigned short)0x6a79,(unsigned short)0xe714,(unsigned short)0xe3c1};

int main(){
  int known_id=3;
  for (int i=0;i<2;i++) {
    printf("[%u]ERROR! list crc 0x%04x - should be 0x%04x\n",i,results[i].crclist,list_known_crc[known_id]);
  }
  return 0;
}
