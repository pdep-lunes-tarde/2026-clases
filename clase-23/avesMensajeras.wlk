// class BombaException inherits DomainException {}

// object bomba {
//     method explotar() {
//         // MessageNotUnderstoodException
//         throw new BombaException(message="Falló")
//     }
// }
// object saludador {
//     method saludar() {
//         try {
//             console.println("Hola")
//             bomba.explotar()
//             console.println("Chau")
//         } catch excepcion: BombaException {
//             console.println("La bomba exploto con error: " + excepcion.message())
//         } catch excepcion: DomainException {
//             console.println("Algo salio mal")
//         }
//     }
// }

class Ciudad {
    const posicion
    const nombre = "caba"
    const necesidades = new Set()
    const productosPorProveedores = new Dictionary()
    // diccionario que va de Ciudad a una lista de productos
    var produccion = "yerba"

    method nombre() = nombre

    method posicion() = posicion

    method distanciaA(otraCiudad) =
        posicion.distance(otraCiudad.posicion())
    
    method produccion() = produccion

    method necesitar(producto) {
        necesidades.add(producto)
    }

    method llevar(producto, ciudad) {
        necesidades.remove(producto)

        // si es la primera vez que me trae algo, lo inicializo con
        // una lista vacia para esa ciudad
        if(!productosPorProveedores.containsKey(ciudad)) {
            productosPorProveedores.put(ciudad, new Set())
        }
        const productosDeCiudad = productosPorProveedores.get(ciudad)
        productosDeCiudad.add(producto)
    }
    // - qué productos recibió una ciudad de parte de otra ciudad en particular.

    method productosRecibidosDe(unaCiudad) {
        return productosPorProveedores.getOrElse(unaCiudad, { [] })
    }

    method cantidadDeProductosDistintosRecibidos() {
        return productosPorProveedores.values().flatten().asSet().size()
    }

    method proveedores() = productosPorProveedores.keys()

    method estaSatisfecha() = necesidades.isEmpty()

    method cantidadDeProductosRecibidosDe(proveedor) {
        return self.productosRecibidosDe(proveedor).size()
    }

    method mayorProveedor() {
        const proveedores = productosPorProveedores.keys()
        return proveedores.max {
            proveedor => self.cantidadDeProductosRecibidosDe(proveedor)
        }
    }
}

class Ave {
    var ciudad
    var energia
    const energiaMaxima = 100

    method descansar() {
        energia = (energia + 10).min(energiaMaxima)
    }

    method volar(ciudadDestino) {
        self.validarQuePuedaVolarA(ciudadDestino)

        const energiaRequerida = self.energiaNecesariaParaLlegarA(ciudadDestino)
        const productoQueLleva = ciudad.produccion()
        const ciudadOrigen = ciudad
        
        energia = energia - energiaRequerida
        ciudad = ciudadDestino

        ciudad.llevar(productoQueLleva, ciudadOrigen)
    }

    method validarQuePuedaVolarA(ciudadDestino) {
        if(!self.puedeVolarA(ciudadDestino)) {
            self.error("No tenia suficiente energia para volar, necesitaba: " + self.energiaNecesariaParaLlegarA(ciudadDestino) + " pero tenia " + energia)
        }
    }

    method energiaNecesariaParaRecorrido(ciudades) {
        return (0..ciudades.size() - 2).sum {
            i => 
                const ciudadOrigen = ciudades.get(i)
                const ciudadDestino = ciudades.get(i + 1)
                return ciudadOrigen.distanciaA(ciudadDestino)
        }
    }

    method validarQuePuedaRealizarRecorrido(ciudades) {
        const energiaRequerida = self.energiaNecesariaParaRecorrido(ciudades)
        if(energiaRequerida > energia) {
            self.error("No tenia suficiente energia para volar, necesitaba: " + energiaRequerida + " pero tenia " + energia)
        }
    }

    method realizarRecorrido(ciudades) {
        self.validarQuePuedaRealizarRecorrido(ciudades)

        ciudades.forEach { ciudadDestino =>
            self.volar(ciudadDestino)
        }
    }

    method puedeVolarA(ciudadDestino) =
        energia >= self.energiaNecesariaParaLlegarA(ciudadDestino)

    method energiaNecesariaParaLlegarA(ciudadDestino) =
        ciudad.distanciaA(ciudadDestino)

    method energia() = energia
    method ciudad() = ciudad
}

const unaCiudad= new Ciudad(posicion=new Position(x=0, y=0))
const ciudadCercana=new Ciudad(posicion=new Position(x=1, y=0))
const ciudadLejana=new Ciudad(posicion=new Position(x=10, y=0))
const ave = new Ave(ciudad=unaCiudad, energia=5)