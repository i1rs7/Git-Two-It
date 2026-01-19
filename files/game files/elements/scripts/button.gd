extends StaticBody2D

@export var connections = []


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_class("TileMapLayer"): return
	if body == self: 
		return
	for element in connections:
		var obj = get_node(element)
		if obj.is_in_group("doors"): 
			obj.button_update(true)
		else: 
			obj.enable()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	for element in connections:
		var obj = get_node(element)
		if obj.is_in_group("doors"): 
			obj.button_update(false)
		else: obj.disable()
