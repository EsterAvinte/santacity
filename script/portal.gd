extends Node2D

@export var nome_porta_saida:String
@export var nome_porta_entrada:String

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var portais = get_tree().get_nodes_in_group("portais")
		var proxima_posicao = position;
		
		for portal in portais:
			
			if portal.get("porta"):
				if portal.nome_porta == nome_porta_saida:
					proxima_posicao = portal.position
		body.position = Vector2(proxima_posicao.y, proxima_posicao.x +20)
