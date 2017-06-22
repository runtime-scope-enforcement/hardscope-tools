struct user {
  char *name;
  int id;
  char hash[4];
};

void create_hash(struct user *u) {
  if (!u) return;
  char *name = u->name;

  char *p = name;
  while (*p) {
    u->hash[0] = *p & 0x0f;
    u->hash[1] = *p & 0xaa;
    u->hash[2] = *p & 0x55;
    u->hash[3] = *p & 0xf0;
    p++;
  }
}

int main() {
  create_hash((void*)0);

  return 0;
}


