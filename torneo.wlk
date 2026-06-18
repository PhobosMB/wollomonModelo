import wollomon.*

class Torneo{
    const participantes = []

    method aprenderAtaqueMasivo(unAtaque){
        participantes.forEach({p => p.aprenderAtaque(unAtaque)})
    }
    
    method batallaEntre(wollomonAtacante,wollomonDefensor){
        if(participantes.contains(wollomonAtacante)&&participantes.contains(wollomonDefensor)){
            wollomonAtacante.atacar(wollomonDefensor)
        }
        else{
            self.error("Uno de los wollomones no se encuentra en el torneo!")
        }
    }

    method participanteDeMayorXp() = participantes.max({p => p.nivelExperiencia()})

    method participanteConMayorPs() = participantes.max({p => p.salud()})



    method batallarAutomaticamente(){
        if(self.participanteDeMayorXp()!=self.participanteConMayorPs()){
            self.participanteDeMayorXp().atacar(self.participanteConMayorPs())
        }
        else{
            self.participanteDeMayorXp().atacar(participantes.max({p => p.salud()}).get(1))
        }
    }

    method wollomonesCriticos() = participantes.filter({p => p.salud() < 50})

    method darPocion(){
        self.wollomonesCriticos().forEach({p => p.curar(20)})
    }
}

