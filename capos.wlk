object rolando {
    const mochila = #{}
    var property hogar = castilloPiedra
    const historia = []
    var property tamañoMochila = 2

    var property poderBase = 5

    method poderBatalla() {
      return self.poderBase() + self.poderDeArtefactos()
    }

    method poderDeArtefactos() {
      return mochila.sum({artefacto => artefacto.poder()})
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
      if (self.mochila().contains(espadaDestino)){
        espadaDestino.usado(true)
      }
      if (self.mochila().contains(collarDivino)) {
        collarDivino.vecesUsado()
      }
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
  var property usado = false

  method poder() {
    if (usado){
        return rolando.poderBase() /2
    }else{
        return rolando.poderBase()
    }
  }
}

object libroDeHechizos {
  
}

object collarDivino {
  var property vecesUsado = 0 

  method vecesUsado() {
    return vecesUsado + 1
  }

  method poder() {
    if (rolando.poderBase() > 6) {
        return 3 + vecesUsado
    }else{
        return 3
    }
  }
}

object armaduraAcero {
  const property poder = 6

  method poder() {
    return poder
  }
}