class Wollomon{
    var property nivelExperiencia
    var property salud = 200
    const property ataques = []

    method puedeAtacar() = salud > 10

    method aprenderAtaque(ataque){ ataques.add(ataque) } 

    method dañoQueEfectua()

    method curar(cantidad){
        salud += cantidad
    }

    method atacar(unWollomon){
        if(self.puedeAtacar()){
            unWollomon.recibirAtaqueDe(self)
            self.efectosDeAtacar()
        }
    }
    method recibirAtaqueDe(unWollomon){
        salud = 0.max(salud - unWollomon.dañoQueEfectua())
    }
    method efectosDeAtacar()
}

class Bicho inherits Wollomon{
    override method dañoQueEfectua() = ataques.sum({a => a.valorDaño()})
    override method efectosDeAtacar(){
        nivelExperiencia += 10
    }
}

class Dragon inherits Wollomon{
    const property fuegoInterior
    override method puedeAtacar() = super() && fuegoInterior > 20
    override method dañoQueEfectua() = fuegoInterior + ataques.max({a => a.valorDaño()}).valorDaño()
    
    override method efectosDeAtacar(){
        nivelExperiencia += fuegoInterior*0.5
    }
}

class Electrico inherits Wollomon{
    method estaCargado() = ambiente.humedad() > 97
    override method puedeAtacar() = super() && self.estaCargado()
    override method dañoQueEfectua(){
        if(self.estaCargado()){
            return ataques.first().valorDaño()
        }
        else{
            return 0
        }
    } 
    override method recibirAtaqueDe(unWollomon){
        super(unWollomon)
        nivelExperiencia -= 1
    }
    override method efectosDeAtacar(){
        if(self.estaCargado()){
            nivelExperiencia += 20
        }
        else{
            nivelExperiencia += 0
        }
    }
}

class Legendario inherits Dragon{
    var insignia
    override method dañoQueEfectua() = super() + insignia.aumentoDeDaño(self) 
}

object insigniaRoja{
    method aumentoDeDaño(dragon){
        if(dragon.fuegoInterior()>20){
            return 10
        }
        else{
            return 5
        }
    }
}

object insigniaAzul{
    method aumentoDeDaño(dragon) = 8
}

object insigniaVerde{
    method aumentoDeDaño(dragon) = 0
}

class Ataque{
    var property valorDaño
}

object ambiente{
    var property humedad = 100

    method cambiarHumedad(nueva){
        humedad = nueva
    }
}