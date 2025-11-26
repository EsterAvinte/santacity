extends Area2D
@export var next_level = ""

func _on_body_entered(_body: Node2D) -> void:
	call_deferred("load_next_level") 
	
func load_next_level():	get_tree().change_scene_to_file("res://scenes/" + next_level + ".tscn")
