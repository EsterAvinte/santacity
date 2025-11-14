extends Camera2D

var alvo:Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buscar_alvo() # Replace with function body.  


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position=alvo.position

func buscar_alvo():
	var nodes=get_tree().get_nodes_in_group("player")
	if nodes.size() == 0:
		push_error("no player nao foi encontrado")
		return
		
	alvo = nodes[0]
