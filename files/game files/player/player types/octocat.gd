extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -250.0
const TRAMP_BOUNCE_VELOCITY = -375.0
@onready var key_collect: AudioStreamPlayer2D = $KeyCollect
@onready var door_open: AudioStreamPlayer2D = $DoorOpen


var key = false
var selected = true


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	move(delta)
	handle_collisions()

func move(delta: float) -> void:
	if not is_on_floor(): velocity += get_gravity() * delta / 2 # Add the gravity.
	if selected: # only evaluate movement if the node is selected
		if Input.is_action_just_pressed("ui_up") and is_on_floor(): 
			velocity.y = JUMP_VELOCITY # Handle jump.
		velocity.x = Input.get_axis("ui_left","ui_right") * SPEED # move based on left and right
		player_animation()
	else:
		velocity.x = 0
	move_and_slide() # Move by velocity.


func handle_collisions():
	#for index in get_slide_collision_count():
		#var collision = get_slide_collision(index)
		#if collision == null: continue
		#var collider = collision.get_collider()
		# Collision checks, I know its bad but here
	if get_last_slide_collision() == null: return
	var collider = get_last_slide_collision().get_collider()
	if collider.is_in_group("doors") and key and collider.opened_by_key:
		collider.disable()
		door_open.play()
		key = false
		get_node("key").hide()
	elif collider.is_in_group("keys"):
		collider.queue_free()
		get_node("key").show()
		key = true
		key_collect.play()
	elif collider.is_in_group("trampolines") and collider.state:
		velocity.y = TRAMP_BOUNCE_VELOCITY
		collider.play_animation()
	elif collider.is_in_group("flags"):
		collider.queue_free()
		get_tree().root.get_child(1).find_child("Level Manager").load_next_level()
		await tree_exited
			
func player_animation():
	var direction = Input.get_axis("ui_left","ui_right")
	if direction > 0:
		$AnimatedSprite2D.play("move_right")
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.play("move_right")
		$AnimatedSprite2D.flip_h = true
	elif direction == 0:
		$AnimatedSprite2D.stop()
		
