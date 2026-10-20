class Hechicero {
	var property energia = 0

	method puedeUsar(unHechizo) = unHechizo.costoEnEnergia() <= energia
	
	method usar(unHechizo, hechiceroAfectado) {
		self.disminuirEnergia(unHechizo.costoEnEnergia())
		unHechizo.afectar(hechiceroAfectado)
	}
	
	method disminuirEnergia(energiaADisminuir) {
		energia = energia - energiaADisminuir
	}
	
	method aumentarEnergia(energiaAAgregar) {
		energia = (energia + energiaAAgregar).min(self.energiaMaxima())
	}
	
	method energia() = energia

	method energiaMaxima()
}

class Aprendiz inherits Hechicero { // el aprendiz es el hechicero en si
	override method energiaMaxima() = 50
	
	override method puedeUsar(unHechizo) =
		super(unHechizo) && unHechizo.costoEnEnergia() <= 40
}

class Archimago inherits Hechicero {
	const nivel = 1
	
	override method energiaMaxima() = 100 + nivel * 2
	
	override method puedeUsar(unHechizo) =
		super(unHechizo) && !unHechizo.esProhibido()
}

class HechiceroSupremo inherits Hechicero {
	override method energiaMaxima() = 500

	override method puedeUsar(unHechizo) = true
}
