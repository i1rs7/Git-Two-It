extends StaticBody2D

@export var opened_by_key = false
@export var initial_state = true
@export var slow_open = false
@export var active_buttons = 0


func _ready() -> void:
	if !initial_state: disable()

func _process(_delta: float) -> void:
	pass


func button_update(pressed: bool):
	if pressed:
		active_buttons += 1
	else:
		active_buttons -= 1

	active_buttons = max(active_buttons, 0)

	print(active_buttons)
	
	if active_buttons > 0:
		disable()
	else:
		enable()


func disable():
	if slow_open: lower_door()
	else: get_child(0).self_modulate.a = 0.25
	get_child(1).set_deferred("disabled", true)
	

func enable():
	get_child(1).set_deferred("disabled", false)
	get_child(0).self_modulate.a = 1

func lower_door():
	var counter = 1
	while counter<10 and self.position.y < 242:
		counter +=1
		self.position.y += 0.05
