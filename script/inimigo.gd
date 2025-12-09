extends CharacterBody2D

@onready var hitbox: Area2D = $Hitbox
@onready var detector_terreno: RayCast2D = $DetecontorTerreno
@onready var detector_parede: RayCast2D = $DetecontorTerreno/DetectorParede
@onready var detector_player: RayCast2D = $DetecontorTerreno/DetectorPlayer


const SPEED = 10.0
const JUMP_VELOCITY = -400.0
enum EstadoInimigo{
	andando,
	atacando,
	morrendo,
}
var estado_inimigo:EstadoInimigo
var direction =1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	ativar_gravidade(delta)
	match estado_inimigo:
		EstadoInimigo.andando:
			estado_andando(delta)
		EstadoInimigo.atacando:
			estado_atacando(delta)
		EstadoInimigo.morrendo:
			estado_morrendo(delta)

	move_and_slide()
	
func prepara_andando():
	estado_inimigo = EstadoInimigo.andando

func prepara_atacando():
	estado_inimigo = EstadoInimigo.atacando
	velocity = Vector2.ZERO
	

func prepara_morrendo():
	estado_inimigo = EstadoInimigo.morrendo
	velocity = Vector2.ZERO
	hitbox.prossed_mode = Node.PROCESS_MODE_DISABLED

func estado_andando(_delta):
	velocity.x = direction * SPEED
	if detector_parede.is_colliding():
		direction *= -1
		scale.x *= -1

	if not detector_terreno.is_colliding():
		direction *= -1
		scale.x *= -1
		
	if detector_player.is_colliding():
		prepara_atacando()
		return 
		
func estado_morrendo(_delta):
	pass
	
func estado_atacando(_delta):
	pass
	
func ativar_gravidade(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
