object snake {
    var position = game.center()
    var direccion = "arriba"

    method reset() {
        position = game.center()
    }

    method posicion(nuevaPosicion) {
        position = nuevaPosicion
    }

    method position() {
        return position
    }

    method image() {
        return "viborita_cabeza_arriba.png"
    }

    method apply() {
        if(direccion == "arriba") {
            position = position.up(1)
        } else {
            position = position.right(1)
        }
    }

    method moverseALaDerecha() {
        direccion = "derecha"
    }
}
