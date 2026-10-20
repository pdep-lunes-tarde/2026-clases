class Hechicero {
	var rango
	var energia = 0
	
	method energia() = energia
	
	method energiaMaxima() = rango.energiaMaxima()

	method puedeUsar(unHechizo) = rango.puedeUsar(unHechizo, energia)
	
	method usar(unHechizo, unHechicero) {
		self.disminuirEnergia(unHechizo.costoEnEnergia())
		unHechizo.afectar(unHechicero)
	}
	
	method disminuirEnergia(energiaADisminuir) {
		energia = energia - energiaADisminuir
	}
	
	method aumentarEnergia(energiaAAgregar) {
		energia = (energia + energiaAAgregar).min(self.energiaMaxima())
	}
	
	method cambiarRango(nuevoRango) {
		rango = nuevoRango
	}
}

class Rango {
	method puedeUsar(unHechizo, energiaDelHechicero) =
		unHechizo.costoEnEnergia() <= energiaDelHechicero
}

class Aprendiz inherits Rango { // el aprendiz representa al rango
	method energiaMaxima() = 50
	
	override method puedeUsar(unHechizo, energiaDelHechicero) =
		unHechizo.costoEnEnergia() <= 40 &&
		super(unHechizo, energiaDelHechicero)
		
}

class Archimago inherits Rango {
	const nivel = 1
	
	method energiaMaxima() = 100 + nivel * 2
	
	override method puedeUsar(unHechizo, energiaDelHechicero) =
		super(unHechizo, energiaDelHechicero) &&
		!unHechizo.esProhibido()
}

class HechiceroSupremo inherits Rango {
	method energiaMaxima() = 500
	override method puedeUsar(unHechizo, energiaDelHechicero) = true
}

