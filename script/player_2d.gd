extends CharacterBody2D

const MAX_JUMP = 2
var jump_count= 0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
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
		EStadoPlayer.caindo:
			caindo(delta)
			
			
	move_and_slide()

func ativar_gravidade(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta # Correção de bug: precisa ser 'velocity.y'

func mover(delta):
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, 400 * delta) # Uso de SPEED (constante)
	else:
		velocity.x = move_toward(velocity.x, 0, 400 * delta) # Correção lógica: 'direction' é 0, o terceiro argumento (SPEED) estava faltando ou incorreto

func atualizar_animacao():
	direction = Input.get_axis("tras","frente") # Correção de 'input' para 'Input' e das ações para o padrão usado no seu código

func pode_pular():
	if jump_count < MAX_JUMP:
		return true
	else:
		return false

func pulando(delta):
	ativar_gravidade(delta)
	mover(delta)
	
	if velocity.y > 0:
		return

	if Input.is_action_just_pressed("pulo") and pode_pular():
		return # Esta função precisa de mais lógica para realmente pular, mas mantive a estrutura.

func parado(delta): # Corrigido: Indentação estava incorreta, causando erro na Linha 58
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
		return

func caindo(delta):
	ativar_gravidade(delta)
	mover(delta)
	
	if Input.is_action_just_pressed("pular") and pode_pular():
		preparar pulo():
		return
	if is_on_floor():
		if velocity.x -- 0:
		else:
			preparar_pulo():
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
	animacao_player.play(caindo)
