class Hechicero {
    var mana
    var vida
    var amuleto = sinAmuleto

    method mana() = mana
    method vida() = vida

    method equiparAmuleto(unAmuleto) {
        amuleto = unAmuleto
    }

    method variarVida(cantidad) {
        vida = vida + cantidad 
    }

    method curarConMagia(cantidad) {
        self.variarVida(cantidad + amuleto.poder())
    }

    method variarMana(cantidad) {
        mana = mana + cantidad
    }

    method hacerMagias(magias) {
        magias.forEach({ magia =>
            if(magia.puedeHacerla(self)) {
                magia.hacerMagia(self)
            }
        })
    }
}

object sinAmuleto {
    method poder() = 0
}

class Amuleto {
    var poder

    method poder() = poder
}

class Meditar {
    method hacerMagia(hechicero) {
        hechicero.variarMana(10)
    }
    method puedeHacerla(hechicero) = true
}

object entrarEnTrance inherits Meditar {
    override method hacerMagia(hechicero) {
        super(hechicero)
        hechicero.curarConMagia(15)
    }
}

// Rezar es una magia que, según la cantidad de horas que se realice, recupera 5 veces su cantidad en mana y 10 veces su cantidad en vida.

class Rezar {
    const horas

    method puedeHacerla(hechicero) = true
    method hacerMagia(hechicero) {
        hechicero.variarMana(5 * horas)
        hechicero.curarConMagia(10 * horas)
    }
}

class Curacion inherits Hechizo {
    const curacion

    override method hacerMagia(hechicero) {
        hechicero.variarMana(- costoMana)
        hechicero.curarConMagia(curacion)
    }
}
const cure = new Curacion(costoMana = 10, curacion = 20)
const cura = new Curacion(costoMana = 25, curacion = 50)
const curaga = new Curacion(costoMana = 50, curacion = 100)

class Hechizo {
    const costoMana

    method puedeHacerla(hechicero) {
        return hechicero.mana() >= costoMana
    }
    method hacerMagia(hechicero)
}

class CrearAmuleto inherits Hechizo {
    const costoVida

    override method hacerMagia(hechicero) {
        hechicero.variarMana(- costoMana)
        hechicero.variarVida(- costoVida)
        const nuevoAmuleto = new Amuleto(poder = costoVida + costoMana)
        hechicero.equiparAmuleto(nuevoAmuleto)
    }
}

// const mago = new Hechicero(mana=10)
