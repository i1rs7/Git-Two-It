extends Node2D

const CAT = preload("res://files/game files/player/player types/cat.tscn")
const OCTOCAT = preload("res://files/game files/player/player types/octocat.tscn")
const OCTOPUS = preload("res://files/game files/player/player types/octopus.tscn")



var split_distance = 20

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("split") and get_child_count() < 2: split()
	if Input.is_action_just_pressed("ui_accept") and get_child_count() > 1: swap()
	if Input.is_action_just_pressed("merge") and input_manager.can_merge: merge()

func merge():
	var cat = get_child(0)
	var oct = get_child(1)
	var octocat = OCTOCAT.instantiate()
	octocat.position = (cat.position+oct.position)/2
	call_deferred("add_child", octocat)
	octocat.selected = true
	octocat.key = cat.key or oct.key
	if octocat.key : octocat.get_node("key").show()
	cat.queue_free()
	oct.queue_free()
	input_manager.set_can_split(true)
	input_manager.set_can_swap(false)


func swap():
	get_child(0).selected = !get_child(0).selected
	get_child(1).selected = !get_child(1).selected

func split():
	var octocat = get_child(0)
	var cat = CAT.instantiate()
	var oct = OCTOPUS.instantiate()
	cat.position = octocat.position + Vector2(split_distance,0)
	oct.position = octocat.position - Vector2(split_distance,0)
	add_child(cat)
	add_child(oct)
	cat.selected = true
	oct.selected = false
	cat.key = octocat.key
	oct.key = false
	if cat.key: cat.get_node("key").show()
	if oct.key: oct.get_node("key").show()
	octocat.queue_free()
	input_manager.set_can_split(false)
	input_manager.set_can_swap(true)
