extends CharacterBody2D

const MAX_JUMP = 2
var jump_count= 0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animacao_player: AnimatedSprite2D = $AnimatedSprite2D

enum EstadoPlayer{
	parado,
	andando,
	pulando
}
var estado_atual:EstadoPlayer
var direction = 0

func _physics_process(delta: float) -> void:
	ativar_gravidade(delta)
	
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	direction = Input.get_axis("tras", "frente")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func ativar_gravidade(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func mover(delta):
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, 400 * delta)
	else:
		velocity.x = move_toward(velocity.x, direction, 0, 400 * delta)

func atualizar_animacao():
	direction = input.get_axis("left","right")

func pode_pular():
	if jump_count < MAX_JUMP:
		return true
	else:
		return false

func pular(delta):
	ativar_gravidade(delta)
	mover(delta)

	if Input.is_action_just_pressed("pulo") and pode_pular():
		return

	if velocity.y > 0:
		return

 func parado(delta):
	ativar_gravidade(delta)
	mover(delta)

	if velocity.x != 0:
		return
	if input.is_action_just_pressed("pulo"):
		preparar_pulo()
		return

func preparar_pulo():
	estado_atual = EstadoPlayer.pulando
	animacao_player.player("pulando")
	velocity.y = JUMP_VELOCITY
	jump_count += 1

func preparar_andando():
	estado_atual = EstadoPlayer.andando
	animacao_player.player("andando")