#define HEAP_TOTAL 4096

typedef unsigned long size_t;
char static_memblk[HEAP_TOTAL];
static size_t start = 0;
static size_t end = 0;

static void abort() {
  while(1) { }
}

void *malloc_1(size_t size) {
  void *a;
  if (start + size >= HEAP_TOTAL) {
    abort();
  }
  a = static_memblk + start;
  start += size;
  return a;
}

void free(void *ptr) {
//haha yea
}
