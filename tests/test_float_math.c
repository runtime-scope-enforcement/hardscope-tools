int main() {
  double x = 3.14;
  double y;
  double tmp;

  y = 22.0 / 7.0;
  
  tmp = x - y;
  if (tmp < .0)
    tmp = -tmp;
  if (tmp < .05)
    return 0;
  return 1;
}
