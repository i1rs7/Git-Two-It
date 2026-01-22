extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("octocat"):
		get_tree().root.get_child(0).find_child("Level Manager").load_next_level()
		await tree_exited
