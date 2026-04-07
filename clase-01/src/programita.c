#include <stdio.h>


int cuantosPares(int numeros[], int tamanio) {
  int nPares = 0;
  for (int i = 0; i < tamanio; i++) {
    if (esPar(numeros[i])) {
      nPares++;
    }
  }
  return nPares;
}

int esPar(int numero) {
  return numero % 2 == 0;
}

int main() {
  int xs[8] = {1, 2, 3, 4, 5, 6, 7, 8};
  printf("--------------\n");
  printf("Respuesta: %d\n", coso(xs, 8));
  printf("--------------\n");
}
+