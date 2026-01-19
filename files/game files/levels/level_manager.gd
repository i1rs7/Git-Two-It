extends Node2D

var levels = []
var num_levels = 6
var current_level = 0


func _ready() -> void:
	for index in num_levels:
		levels.append(load("res://files/game files/levels/level " + str(index + 1) + ".tscn"))
	load_next_level()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"): restart_level()

func load_next_level():
	assert(levels.size() > current_level, "next level not found - update var num_levels and ensure all level scenes are named and stored correctly")
	if $"../Settings".visible:
		Input.action_press("pause")
		Input.action_release("pause")
	get_child(0).queue_free()
	await get_child(0).tree_exited
	add_child(levels[current_level].instantiate())
	current_level += 1
	if current_level == 6:
		$"../UI".force_credits()

func load_level(num: int):
	current_level = num - 1
	load_next_level()

func restart_level():
	current_level -= 1
	load_next_level()
