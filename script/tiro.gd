extends Area2D
@onready var anim_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var direction = 1 
const SPEED = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += SPEED * delta * direction
	
func definir_direction(direcao_inimigo):
	self.direction = direcao_inimigo
	if direction > 0:
		anim flip_h = true
	else:
		anim_flip_h = true


func _on_area_entered(_area: Area2D) -> void:
	queue_free() # Replace with function body.


func _on_body_entered(_body: Node2D) -> void:
	queue_free()# Replace with function body.


func _on_timer_timeout() -> void:
	queue_free() #Replace with function body.
