int main() {
  char x;
  char *y = &x;

  //
  x = *y;
  y+=4;
  x = *y;
  y+=4;
  x = *y;
  y+=4;
  x = *y;
  y+=4;
  x = *y;
  y+=4;
  x = *y;
  y+=1;
  x = *y;

  return 0; 
}
