;#define HEAP_TOTAL (1000)


malloc:
.global malloc
#ifdef HAVE_XSCEN_V2
  srdda -32(sp), sp 
#else
  srbse -32(sp)
  srlmt -1(sp)
#endif
  add sp,sp,-32
  sw  ra,28(sp)
  sw  a0,24(sp)
  sbent
  jal malloc_1
  lw  ra,28(sp)
  lw  t1,24(sp)
  add t1,t1,a0
#ifdef HAVE_XSCEN_V2
  srdsub a0,-1(t1)
#else
  srsub a0,-1(t1)
  srdlgm  a0
#endif
  add sp,sp,32
  sbxit
  jr  ra

