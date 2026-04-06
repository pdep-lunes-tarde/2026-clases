#include <stdio.h>

int coso(int a[], int b) {
  int c, d = 0;
  for (c = 0; c < b; c++) {
    if (a[c] % 2 == 0) {
      d = d + 1;
    }
  }
  return d;
}

int main() {
  int xs[8] = {1, 2, 3, 4, 5, 6, 7, 8};
  printf("--------------\n");
  printf("Respuesta: %d\n", coso(xs, 8));
  printf("--------------\n");
}
