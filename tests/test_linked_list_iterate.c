struct link {
  struct link *next;
  int val;
};

void make_chain(int n, struct link **start) {
  struct link *l = malloc(sizeof(struct link));
  *start = l;
  for (int i=0;i<n;i++) {
    l->next = malloc(sizeof(struct link));
    l = l->next;
    l->val = i*i;
    l->next = (void*)0;
  }
}

int sum_list(struct link *l) {
  int sum = 0;
  do {
    sum += l->val;
    l = l->next;
  } while (l);
  return sum;
}

int main() {
  struct link *mylist = (void*)0;

  make_chain(4, &mylist);
  sum_list(mylist);


  return 0;
}
