// 1
// Pepita es una golondrina que puede volar y comer.
// Nos interesará consultar cuál es su energía antes y después de volar y comer (o en cualquier otro momento que querramos).

// Sabemos que:
// Al volar gasta 5 joules de energía por cada kilómetro volado, más 40 joules para comenzar a volar.
// Por cada gramo que come gana 2 joules de energía.
// Inicialmente su energía es 100 joules.

object pepita {
    var energia = 100
    method energia(){
        return energia
    }
    method vola(kilometros){
        energia = (energia - 40 - 5 * kilometros).max(0)
    }
    method come(gramos){
        energia = energia + gramos * 2
    }
}

// 2
// Josefa es una paloma que también puede volar y comer, sólo que distinto.
// Nos interesará consultar cuál es su energía, que se calcula en base a su energía inicial (80), cuántos kilómetros voló y cuántos gramos comió.
// La energia de josefa es igual a: su energia inicial (80) + 3 por cada gramo comido - 5 por cada kilometro volado

object josefa {
    var kilometrosVolados = 0
    var gramosComidos = 0
    const energiaInicial = 80
    method energia(){
        return energiaInicial - kilometrosVolados * 5 + gramosComidos * 3
    }
    method vola(kilometros){
        kilometrosVolados = kilometrosVolados + kilometros
    }
    method come(gramos){
        gramosComidos = gramosComidos + gramos
    }
 
    // Además, queremos poder preguntarle a Josefa cómo se siente, y debe respondernos:
    // "Bonita y gordita" si le dimos más de comer de lo que la hicimos volar
    // "Enérgica" si su energía es mayor a su energía inicial
    // "Indiferente" en cualquier otro caso

    method comoTeSentis(){
        if ( gramosComidos > kilometrosVolados ){
            return "Bonita y gordita"
        } else if( energiaInicial < self.energia() ) {
            return "Enérgica"
        }
        else {
            return "Indiferente"
        }
    }
}

// 3
// Agregamos a nuestro sistema a un entrenador. Su rutina de entrenamiento para un pajarito es la siguiente:
// Darle de comer 10 gramos de alpiste
// Mandarlo a volar 20 kilómetros
// Si luego de volar la energía del pajarito es menor a 20, darle de comer 10 gramos de alpiste, de lo contrario darle de comer 2 gramos.

object entrenador 
{
    method entrena(ave){
        ave.come(10)
        ave.vola(20)
        if ( ave.energia() < 20 ){
            ave.come(10)
        } else{
            ave.come(2)
        }
    }
}

// 4
// Vamos a agregar un ave que tiene una compañera, su nombre es beti y se va a comportar así: su energía va a ser la misma que la de su compañera,
// cuando come x cantidad, le da de comer la mitad a su compañera, y cuando vuela x kms, su compañera también.
// Queremos que pueda cambiar de compañera
// Y su compañera inicial es pepita

// Este no lo llegamos a mostrar en clase:
object beti {
    var companiera = pepita
    method cambiarCompaniera(nuevaCompaniera) {
        companiera = nuevaCompaniera
    }
    method energia() {
        return companiera.energia()
    }
    method vola(kilometros) {
        companiera.vola(kilometros)
    }
    method come(gramos) {
        companiera.come(gramos / 2)
    }
}
