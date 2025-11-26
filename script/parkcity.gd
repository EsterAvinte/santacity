extends Node2D
@onready var bgm: AudioStreamPlayer = $BGM

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if bgm.stream:
		if bgm.stream.has_method("set_loop"):
			bgm.stream.set_loop(true)
	bgm.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func stop_bgm():
	if is_instance_valid(bgm) and bgm.playing:
		var tween = create_tween()
		tween.tween_property(bgm,"volume_db", -80, 1.5)
		tween.tween_callback(bgm.stop)
	  
