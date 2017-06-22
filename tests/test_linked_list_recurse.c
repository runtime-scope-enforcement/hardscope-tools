struct link {
  struct link *next;
  int val;
};

struct link *make_chain(int n) {
  struct link *head = malloc(sizeof(struct link));
  struct link *l = head;
  for (int i=0;i<n;i++) {
    l->next = malloc(sizeof(struct link));
    l = l->next;
    l->val = i*i;
    l->next = (void*)0;
  }
  return head;
}

int sum_list(struct link *l) {
  if (!l) return 0;
  return sum_list(l->next)+l->val;
}

int main() {
  struct link *mylist = (void*)0;

  mylist = make_chain(4);
  sum_list(mylist);


  return 0;
}
