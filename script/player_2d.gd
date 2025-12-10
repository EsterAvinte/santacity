extends CharacterBody2D

const MAX_JUMP = 2
var jump_count= 0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var jump_pad_max = -500
@onready var animacao_player: AnimatedSprite2D = $AnimatedSprite2D

enum EstadoPlayer{
	parado,
	andando,
	pulando,
	caindo,
}
var estado_atual:EstadoPlayer
var direction = 0

func _ready()-> void:
	preparar_parado()
	
	
func _physics_process(delta: float) -> void:
	match estado_atual:
		EstadoPlayer.parado:
			parado(delta)
		EstadoPlayer.andando:
			andando(delta)
		EstadoPlayer.pulando:
			pulando(delta)
		EstadoPlayer.caindo:
			caindo(delta)
	
	
	move_and_slide()
	
	

func ativar_gravidade(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta 

func mover(delta):
	atualizar_animacao()
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, 400 * delta) # Uso de SPEED (constante)
	else:
		velocity.x = move_toward(velocity.x, 0, 400 * delta)
	
func atualizar_animacao():
	direction = Input.get_axis("tras","frente") 
	if direction < 0:
		animacao_player.flip_h = true
	elif direction > 0:
		animacao_player.flip_h = false

func pode_pular():
	if jump_count < MAX_JUMP:
		return true
	else:
		return false

func pulando(delta):
	ativar_gravidade(delta)
	mover(delta)
	
	if velocity.y > 0:
		preparar_caindo()
		return

	if Input.is_action_just_pressed("pulo") and pode_pular():
		preparar_pulo()
		return # Esta função precisa de mais lógica para realmente pular, mas mantive a estrutura.

func parado(delta):
	ativar_gravidade(delta)
	mover(delta)
	
	if velocity.x != 0:
		return
	
	if Input.is_action_just_pressed("pulo"): # Corrigido: 'input' para 'Input'
		preparar_pulo()
		return

func andando(delta):
	ativar_gravidade(delta)
	mover(delta)
	
	if velocity.x == 0:
		return
	
	if Input.is_action_just_pressed("pulo"):
		preparar_pulo()
		return
	
	if not is_on_floor():
		jump_count += 1
		preparar_caindo()
		return

func caindo(delta):
	ativar_gravidade(delta)
	mover(delta)
	
	if Input.is_action_just_pressed("pulo") and pode_pular():
		preparar_pulo()
		return
	
	if is_on_floor():
		jump_count = 0
	
		if velocity.x == 0:
			preparar_parado()
		else:
			preparar_andando()
			return

func preparar_pulo():
	estado_atual = EstadoPlayer.pulando
	animacao_player.play("pulando") # Corrigido: 'player' para 'play'
	velocity.y = JUMP_VELOCITY
	jump_count += 1

func preparar_andando(): # Corrigido: Indentação estava incorreta, causando erro na Linha 70
	estado_atual = EstadoPlayer.andando
	animacao_player.play("andando") # Corrigido: 'player' para 'play'

func preparar_parado(): # Corrigido: Indentação estava incorreta, causando erro na Linha 70
	estado_atual = EstadoPlayer.parado
	animacao_player.play("parado") # Corr

func preparar_caindo():
	estado_atual = EstadoPlayer.caindo
	animacao_player.play("parado")


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("inimigos"):
		print("player atigindo")
	elif area.is_in_group("Tiro"):
		print("player levou tiro")


func _on_hitbox_body_entered(body: Node2D) -> void:
	 if body.is_in_group("inimigos"):
		print("player atigindo")
	elif body.is_in_group("Tiro"):
		print("player levou tiro")
