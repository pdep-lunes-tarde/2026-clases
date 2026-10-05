// De los alquimistas sabemos que tienen una suerte y una cantidad de salud, ambos valores los representamos con números.

// Los ingredientes de pociones que conocemos por ahora son:
// - Bigote de gato, cuya rareza es 1.
// - Trébol, que si tienen 4 hojas su rareza es de 20, si no, es de 1.
// - Hiedra venenosa, cuya rareza es igual a la concentración de veneno que poseen, la cual podemos representar con un número.

class Alquimista {
    var salud
    var suerte

    method aplicarPocion(pocion) {
        pocion.afectar(self)
    }

    method aumentarSalud(cantidad) {
        salud = 0.max(salud + cantidad)
    }

    method disminuirSalud(cantidad) {
        salud = 0.max(salud - cantidad)
    }

    method aumentarSuerte(cantidad) {
        suerte = 0.max(suerte + cantidad)
    }
}

object bigoteDeGato {
    method rareza() = 1

    method afectar(alquimista) {
        alquimista.aumentarSalud(1)
        alquimista.aumentarSuerte(1)
    }

    method hervir() {
        // no hace nada
    }
}

class Trebol {
    var hojas

    method rareza() = if (hojas == 4) 20 else 1

    method afectar(alquimista) {
        if (hojas == 4) {
            alquimista.aumentarSuerte(20)
        }
    }

    method hervir() {
        hojas -= 1
    }
}

class HiedraVenenosa {
    var concentracionDeVeneno

    method rareza() = concentracionDeVeneno

    method afectar(alquimista) {
        alquimista.disminuirSalud(2 * concentracionDeVeneno)
    }

    method hervir() {
        concentracionDeVeneno *= 2
    }
}

class Pocion {
    var ingredientes = []

    // method ingredientes() = ingredientes.copy() // copy() aca nos sirve para evitar modificar la lista de ingredientes

    method agregar(unIngrediente) {
        ingredientes.add(unIngrediente)
    }

    method cantidadDeIngredientes() {
        return ingredientes.size()
    }

    method rareza() {
        if (ingredientes.isEmpty()) {
            return 0
        }

        const rarezaTotal = ingredientes.sum{ ingrediente => ingrediente.rareza() } //ingredientes.map{ ingrediente => ingrediente.rareza() }.sum()

        return rarezaTotal / self.cantidadDeIngredientes()
    }

    method afectar(alquimista) {
        ingredientes.forEach{ ingrediente => ingrediente.afectar(alquimista) }
    }

    method destilar() {
        //ingredientes = ingredientes.filter{ ingrediente => ingrediente.rareza() > 5 } // filter es de consulta, NO de efecto
        ingredientes.removeAllSuchThat{ ingrediente => ingrediente.rareza() <= 5 }
    }

    method hervir() {
        ingredientes.forEach{ ingrediente => ingrediente.hervir() }
    }
}

// 1. Conocer cuántos ingredientes tiene una poción.


// 2. Poder agregar un ingrediente a una poción.


// 3. Cuál es la rareza de una poción, que es el promedio de rarezas de sus ingredientes. Si no tiene ingredientes, la rareza es 0.


// 4. Cómo afecta una poción a un alquimista, que es aplicar los efectos de cada uno de sus ingredientes:
// - El bigote de gato aumenta la suerte del alquimista en 1 y la salud también en 1.
// - El trébol aumenta la suerte del alquimista en 20 pero solo si es de 4 hojas, si no, no hace nada.
// - La hiedra venenosa disminuye la salud del alquimista en 2 * la concentración de veneno que tiene.


// 5. Queremos destilar una poción, lo cual la deja solo con sus ingredientes de rareza mayor a 5.


// 6. Queremos hervir la poción, lo cual hierve cada uno de sus ingredientes
// - Al hervir el bigote de gato queda igual.
// - El trébol pierde una hoja.
// - La hiedra venenosa aumenta su concentración, la cual se multiplica por 2.


// 7. Queremos que una poción pueda ser ingrediente de otra poción.


// Venta de pociones
// 8. Queremos mantener un registro de las ventas de un alquimista.
// Cuando un alquimista vende una poción, queremos registrar:
// - A quién se la vendió (que va a ser otro alquimista).
// - Cuál fue la poción vendida.

// Esta información la queremos poder consultar para saber:
// - Cuántos clientes tiene.
// - Si es un alquimista gourmet, que se cumple si sólo vende pociones de rareza mayor a 5.
// - Cuál es su cliente favorito, que es aquel que compró más pociones.

