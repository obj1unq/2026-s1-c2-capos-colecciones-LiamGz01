object rolando {
    const mochila = #{}
    var property hogar = castilloPiedra
    const historia = []
    const enemigosDeErethia = #{caterina, archibaldo, astra}

    var property tamañoMochila = 2

    var property poderBase = 5

    method poderDeBatalla() {
      return self.poderBase() + self.poderDeArtefactos()
    }

    method poderDeArtefactos() {
      return mochila.sum({artefacto => artefacto.poderQueAporta()})
    }

    method encontrar(artefacto) {
        if (mochila.size() == tamañoMochila){
            historia.add(artefacto)
            self.error("No puede levantar objeto")
        }else{
            mochila.add(artefacto)
            historia.add(artefacto)
        }
    }

    method mochila() {
      return mochila
    }

    method posesiones() {
        const posesiones = #{}
        posesiones.addAll(mochila)
        posesiones.addAll(hogar.almacen())
        return posesiones
    }

    method historia() {
      return historia
    }

    method poseeArtefacto(artefacto) {
      return (self.posesiones().contains(artefacto))
    }

    method llegarAHogar() {
      hogar.depositasArtefactosDe(self)
    }

    method almacenDe() {
      return hogar.almacen()
    }

    method batallar() {
      self.mochila().forEach({artefacto => artefacto.usar()})

      poderBase = poderBase + 1
    }

    method puedeVencer(enemigo) {
      return (self.poderDeBatalla() > enemigo.poderDePelea())
    }

    method enemigosVencidos() {
      return enemigosDeErethia.filter({enemigo => self.puedeVencer(enemigo)})
    }

    method moradasConquistadas() {
      return self.enemigosVencidos().map({enemigo => enemigo.morada()})
    }

    method esPoderoso() {
      return enemigosDeErethia.all({enemigo => self.puedeVencer(enemigo)})
    }

    method tieneArtefactoFatalPara(enemigo) {
      return mochila.any({artefacto => artefacto.poderQueAporta() > enemigo.poderDePelea()})
    }

    method artefactoFatalPara(enemigo) {
      return mochila.find({ artefacto => artefacto.poderQueAporta() > enemigo.poderDePelea()})
    }
    
}

object castilloPiedra {
  const almacen = #{}

  method depositasArtefactosDe(personaje) {
    almacen.addAll(personaje.mochila())
    personaje.mochila().clear()
    //posesiones.addAll(almacen)
  }

  method almacen() {
    return almacen
  }


}

object espadaDestino {
  var property artefactoUsado = false

  method usar() {
    artefactoUsado = true
  }

  method poderQueAporta() {
    if (artefactoUsado){
        return rolando.poderBase() /2
    }else{
        return rolando.poderBase()
    }
  }
}

object libroDeHechizos {

  const hechizos = [bendicion, invisibilidad, invocacion]

  method poderQueAporta() {
    if (hechizos.isEmpty()){
      return 0
    }else{
      return hechizos.first().poderQueAporta()
    }
  }

  method usar() {
    if (!hechizos.isEmpty()){
      hechizos.remove(hechizos.first())
    }
  }
}
object bendicion {
  const poderQueAporta = 4

  method poderQueAporta() {
    return poderQueAporta
  } 
}
object invisibilidad {
  method poderQueAporta() {
    return rolando.poderBase()
  }
}
object invocacion {
  
  method poderQueAporta() {
    if (castilloPiedra.almacen().isEmpty()) {
      return 0
    }else{
      const masPoderoso = castilloPiedra.almacen().max({artefacto => artefacto.poderQueAporta()})
      return masPoderoso.poderQueAporta()
    }
  }
}


object collarDivino {
  var property vecesUsado = 0 

  method usar() {
    vecesUsado = vecesUsado + 1
  }

  method poderQueAporta() {
    if (rolando.poderBase() > 6) {
        return 3 + vecesUsado
    }else{
        return 3
    }
  }
}

object armaduraAcero {
  const property poderQueAporta = 6

  method poderQueAporta() {
    return poderQueAporta
  }

  method usar() {
    return poderQueAporta
  }
}

//Enemigo de Rolando

object caterina {
  const morada = "FortalezaDeAcero"
  const poderDePelea = 28

  method poderDePelea() {
    return poderDePelea
  } 
  method morada() {
    return morada
  }
}

object archibaldo {
  const morada = "PalacioDeMarmol"
  const poderDePelea = 16

  method poderDePelea() {
    return poderDePelea
  }

  method morada() {
    return morada
  }
}

object astra {
  const morada = "TorreDeMarfil" 
  const poderDePelea = 14

  method poderDePelea() {
    return poderDePelea
  }

  method morada() {
    return morada
  }
}
