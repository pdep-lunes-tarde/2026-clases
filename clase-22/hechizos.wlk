class HechizoCurativo {
	const property costoEnEnergia
	method esProhibido() = false
	method afectar(hechicero) {
		hechicero.aumentarEnergia(costoEnEnergia * 2)
	}
}

object hechizoMortal {
	method costoEnEnergia() = 100
	method esProhibido() = true
    method afectar(hechicero) {
        hechicero.disminuirEnergia(hechicero.energia())
    }
}