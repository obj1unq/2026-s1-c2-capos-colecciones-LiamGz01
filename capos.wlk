object rolando {
    const mochila = #{}
    var property hogar = castilloPiedra
    const historia = []
    //const enemigosDeErethia = #{caterina, archibaldo, astra}
    
    
    var property tamañoMochila = 2

    var property poderBase = 5

    method poderDeBatalla() {
      return self.poderBase() + self.poderDeArtefactos()
    }

    method poderDeArtefactos() {
      return mochila.sum({artefacto => artefacto.poderQueAporta(self)})
    }

    method encontrar(artefacto) {

// CODIGO ANTERIOR
        /*if (mochila.size() == tamañoMochila){
            historia.add(artefacto)
            self.error("No puede levantar objeto")
        }else{
            mochila.add(artefacto)
            historia.add(artefacto)
        }*/
        
        if (mochila.size() != tamañoMochila){
          mochila.add(artefacto)
        }
        historia.add(artefacto)
        
    }

    method mochila() {
      return mochila
    }

    method posesiones() {
        const posesiones = #{}
        posesiones.addAll(mochila)
        posesiones.addAll(hogar.almacen())
        return posesiones
        //return mochila + hogar.almacen()
    }

    method historia() {
      return historia
    }

    method poseeArtefacto(artefacto) {
      return (self.posesiones().contains(artefacto))
    }

    method llegarAHogar() {
      hogar.depositasArtefactosDe(self)
      self.mochila().clear()
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
      return erethia.enemigos().filter({enemigo => self.puedeVencer(enemigo)})
//      return enemigosDeErethia.filter({enemigo => self.puedeVencer(enemigo)})
    }

    method moradasConquistadas() {
      return self.enemigosVencidos().map({enemigo => enemigo.morada()})
    }

    method esPoderoso() {
      return erethia.enemigos().all({enemigo => self.puedeVencer(enemigo)})
//      return enemigosDeErethia.all({enemigo => self.puedeVencer(enemigo)})
    }

    method tieneArtefactoFatalPara(enemigo) {
      return mochila.any({artefacto => artefacto.poderQueAporta(self) > enemigo.poderDePelea()})
    }

    method artefactoFatalPara(enemigo) {
      return mochila.find({ artefacto => artefacto.poderQueAporta(self) > enemigo.poderDePelea()})
    }
    
}

object erethia {
  const enemigos = #{caterina, archibaldo, astra}

  method enemigos() {
    return enemigos
  }
}

object castilloPiedra {
  const almacen = #{}

  method hogarConArtefactos() {
      return almacen.isEmpty()
    }
  method depositasArtefactosDe(personaje) {
    almacen.addAll(personaje.mochila())
        
  }

  method almacen() {
    return almacen
  }

  
  method tieneArtefactos() {
    return !almacen.isEmpty()
  }
  

  method artefactoMasPoderoso(personaje) {
    return almacen.max({ artefacto => artefacto.poderQueAporta(personaje) })
  }
}

object espadaDestino {
  var property artefactoUsado = false

  method usar() {
    artefactoUsado = true
  }
  /*method poderQueAporta() {
    if (artefactoUsado){
        return rolando.poderBase() /2
    }else{
        return rolando.poderBase()
    }
  }*/
    method poderQueAporta(personaje) {
    if (artefactoUsado){
        return personaje.poderBase() /2
    }else{
        return personaje.poderBase()
    }
  }
}

object libroDeHechizos {
  const hechizos = [bendicion, invisibilidad, invocacion]

  method poderQueAporta(personaje) {
    if (hechizos.isEmpty()){
      return 0
    }else{
      return hechizos.first().poderQueAporta(personaje)
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

  method poderQueAporta(personaje) {
    return poderQueAporta
  } 
}
object invisibilidad {
  /*method poderQueAporta() {
    return rolando.poderBase()
  }*/
  
  method poderQueAporta(personaje) {
    return personaje.poderBase()
  }
  
}
object invocacion {
  
  /*method poderQueAporta() {
//  if (castilloPiedra.tieneArtefactos()) {
    if (castilloPiedra.almacen().isEmpty()) {
      return 0
    }else{
      const masPoderoso = castilloPiedra.almacen().max({artefacto => artefacto.poderQueAporta()})
      return masPoderoso.poderQueAporta()
    }
  }*/

  
  method poderQueAporta(personaje) {
    if (personaje.hogar().hogarConArtefactos()) {
      return 0
    }else{
      const masPoderoso = personaje.hogar().artefactoMasPoderoso(personaje)
      return masPoderoso.poderQueAporta(personaje)
    }
  }
}


object collarDivino {
  var property vecesUsado = 0 

  method usar() {
    vecesUsado = vecesUsado + 1
  }
  /*
  method poderQueAporta() { // poderQueAporta(personaje)
    if (rolando.poderBase() > 6) { // if (personaje.poderBase() > 6)
        return 3 + vecesUsado
    }else{
        return 3
    }
  }*/
  method poderQueAporta(personaje) {
    if (personaje.poderBase() > 6) {
      return 3 + vecesUsado
    }else{
      return 3
    }
  }


}

object armaduraAcero {
  const property poderQueAporta = 6

  method poderQueAporta(personaje) {
    return poderQueAporta
  }

  method usar() {
    return poderQueAporta
  }
}

//Enemigo de Rolando

object caterina {
  const morada = fortalezaDeAcero
  const poderDePelea = 28

  method poderDePelea() {
    return poderDePelea
  } 
  method morada() {
    return morada
  }
}

object fortalezaDeAcero {
  
}

object archibaldo {
  const morada = palacioDeMarmol
  const poderDePelea = 16

  method poderDePelea() {
    return poderDePelea
  }

  method morada() {
    return morada
  }
}

object palacioDeMarmol {
  
}

object astra {
  const morada = torreDeMarfil  
  const poderDePelea = 14

  method poderDePelea() {
    return poderDePelea
  }

  method morada() {
    return morada
  }
}

object torreDeMarfil {
  
}
