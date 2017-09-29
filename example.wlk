class Musico{
	var habilidad=0
	var albumes=[]
	var tocaEnGrupo
	constructor(_habilidad,_albumes,_tocaEnGrupo){
		habilidad=_habilidad
		albumes=_albumes
		tocaEnGrupo=_tocaEnGrupo
	}
	method habilidad(){
		return habilidad
	}
	method albumesPublicados(){
		return albumes
	}
	method tocaEnGrupo(){
		return tocaEnGrupo
	}
	
	method esMinimalista(){
		return albumes.all({canciones=>canciones.all{cancion=>cancion.esCorta()}})
	}
	method cancionesQueContienen(palabra){
		return albumes.filter({canciones=>canciones.filter({cancion=>cancion.letra().contains(palabra)})})
	}
	method duracionObra(){
		return albumes.sum({canciones=>canciones.sum({cancion=>cancion.duracion()})})
	}
	
	method laPego(){
		return albumes.all({album=>album.buenaVenta()})
	}
}

class MusicoDeGrupo inherits Musico{
	var costoPresentacion
	var aumento
	constructor(_habilidad,_albumesPublicados,_tocaEnGrupo,_aumento)=super(_habilidad,_albumesPublicados,_tocaEnGrupo){
		aumento=_aumento
	}
	override method tocaEnGrupo(){
		habilidad+=aumento
		return true
	}
	
	method ejecutaBien(cancion) {
		return cancion.duracion()>300 
	}	
	
	method costoPresentacion(){
		if(self.tocaEnGrupo()){
			costoPresentacion=100
		}else{
			costoPresentacion=50
		}
		return costoPresentacion
	}
}

class VocalistaPopular inherits Musico{
	var costoPresentacion=400
	var palabra
	constructor(_habilidad,_albumesPublicados,_tocaEnGrupo,_palabra)=super(_habilidad,_albumesPublicados,_tocaEnGrupo){
		palabra=_palabra
	}
	
	override method habilidad(){
		if(self.tocaEnGrupo()){
			habilidad-=20
		}
		return habilidad
	} 
	method ejecutaBien(cancion) {
		return cancion.letra().contains(palabra) 
	}
	method tocaEn(presentacion){
		if(presentacion.lugar().capacidad()>5000){
		costoPresentacion=500
		}
	}	
	method costoPresentacion(){
		return costoPresentacion
	}
}

object luisAlberto inherits Musico(8,albumes,false) {
	var costoPresentacion
	var guitarra
	
	method agregarAlbumes(_albumes){
		albumes=_albumes
	}
	method guitarra(_guitarra){
		guitarra=_guitarra
	}
	override method habilidad(){
		return (8*guitarra.precio()).min(100)
	}
	
	method ejecutaBien(cancion) {
		return true
	}
	method despuesSeptiembre(presentacion){
		if(presentacion.fecha()>new Date(01,09,2017)){
			costoPresentacion=1200
		}
	}	
	method costoPresentacion(){
		return costoPresentacion
	}
}

object fender{
	var precio=10
	method precio(){
		return precio
	}
}
object gibson{
	var precio=15
	method precio(){
		return precio
	}
	method estaRota(){
		precio=5
	}
}

class Cancion{
	var titulo=""
	var duracion=0
	var letra=""
	
	constructor(_titulo,_duracion,_letra){
		titulo=_titulo
		duracion=_duracion
		letra=_letra
	}
	
	method titulo(){
		return titulo
	}
	method duracion(){
		return duracion
	}
	
	method letra(){
		return letra
	}
	method esCorta(){
		return duracion<180
	}
}

class Presentacion{
	var fecha=new Date()
	var artistas=[]
	var lugar
	
	constructor(_lugar,_artistas,_fecha){
		lugar=_lugar
		artistas=_artistas
		fecha=_fecha
	}
	
	method lugar(){
		return lugar
	}

	method fecha(){
		return fecha
	}
	
	method costo(){
		return artistas.sum({artista=>artista.costoPresentacion()})
	}
	
}

object lunaPark{
	var capacidad=9290
	method capacidad(){
		return capacidad
	}
}

object laTrastienda{
	var capacidad=400
	method capacidad(){
		return capacidad
	}
	method esSabado(presentacion){
		if(presentacion.fecha().dayOfWeek()==6)capacidad+=300
}
}

class Album{
	var titulo
	var canciones=[]
	var fechaLanzamiento=new Date()
	var enVenta
	var vendidas
	
	constructor(_titulo,_canciones,_fechaLanzamiento,_enVenta,_vendidas){
		titulo=_titulo
		canciones=_canciones
		fechaLanzamiento=_fechaLanzamiento
		enVenta=_enVenta
		vendidas=_vendidas
		}
	
	method cancionMasLarga(){
		return canciones.max({cancion=>cancion.letra().size()})
	}
	
	method buenaVenta(){
		return vendidas>enVenta*0.75
	}
}
