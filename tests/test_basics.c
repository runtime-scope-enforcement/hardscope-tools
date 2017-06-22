#include <stddef.h>
#include <stdio.h>

void *memcpy(void *dst, const void *src, size_t n) {
  char *cd = (char*)dst;
  const char *cs = (char*)src;
  for (size_t i = 0;i<n;i++) {
    cd[i] = cs[i];
  }
  return dst;
}

size_t strlen(const char *s) {
  size_t len = 0;
  while(s[len]) len++; 
  return len;
}

char *strcpy(char *dst, const char *src) {
  return (char*) memcpy(dst, src, strlen(src));
}

static char *digits = "0123456789";

int strf(char x, void *data, char *result, int resultlen) {
  char *p = result+resultlen;
  int i;
  char *s;
  size_t len;
  switch(x) {
    case 'd':
      i = *(int*)data;
      while(1) {
        *p++ = digits[i%10];
        if (i<10) break;
        i /= 10;
      }
      break;
    case 'f':
      break;
    case 'b':
    case 'e':

      break;
    case 'c':

      break;
    case 's':
      s = (char*)data;
      len = strlen(s);
      strcpy(p, s);
      p+=len;
      break;
  }
  *p = '\0';
  return p-result;
}

static int uid = 123;
static char *username = "user";
int main() {
  char buf[100];
  char *fmtstr = "hello %s %d";
  void *argdata[2];
  argdata[0] = (void*)username;
  argdata[1] = (void*)&uid;

  int len = 0;
  for (int i=0,j=0;i<strlen(fmtstr);i++) {
    if (fmtstr[i] == '%') {
      len+=strf(fmtstr[++i], argdata[j++], buf, len);
    } else {
      buf[len] = fmtstr[i];
      len++;
    }
  }
  return 0;
}
