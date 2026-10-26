## Enunciado: Aves mensajeras

### Aves

Contamos con varias aves, de las que conocemos cuánta energía tienen y en qué ciudad se encuentran (siempre están en alguna).

Lo que queremos pedirle a un ave es que vuele a una ciudad, lo cual reduce su energía en la cantidad de metros que separa ambas ciudades y luego de eso la ciudad en la que se encuentra es aquella a la que voló.

**IMPORTANTE:** Solo puede volar si tiene suficiente energía.

También queremos pedirle que realice un recorrido por distintas ciudades. Al hacer esto, vuela de una ciudad a otra sucesivamente hasta llegar a la última. Si el recorrido no se puede completar por falta de energía no debería ni siquiera comenzarlo.

### Ciudades

De las ciudades conocemos su posición en un mapa imaginario 2d, o sea que con x e y. Y la distancia entre ellas es la distancia entre sus ubicaciones.

En la ciudad puede surgir la necesidad de cierto producto. Y para cubrirla hay que llevar ese producto a la ciudad.

Queremos saber cuales son las necesidades de una ciudad, poder dar un producto a una ciudad y saber si una ciudad está satisfecha, que es cuando no tiene necesidades sin cubrir.

### Transportando productos

Además, cada ciudad tiene un producto que produce y ofrece. Este producto podría cambiar a lo largo del tiempo.

Las aves pueden llevar un producto de la ciudad en la que están a otra de destino. Cuando hacen esto, viajan a la otra ciudad y dan el producto que ofrece la ciudad de la que salieron.

## Llevando registro

Cada ciudad recuerda todos los productos que recibió de otras ciudades.

Queremos saber:
- cuántos proveedores tiene. Un proveedor es una ciudad de la que recibió un producto.
- qué productos recibió una ciudad de parte de otra ciudad en particular.
- ¿cuál es el mayor proveedor de una ciudad?, qué es aquel que le envió más productos.
- ¿cuántos productos distintos recibió en toda su historia?
