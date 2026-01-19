extends Control

@onready var split: TextureRect = $SplitUI/Split
@onready var split_button: Button = $SplitUI/SplitButton
@onready var merge: TextureRect = $MergeUI/Merge
@onready var merge_button: Button = $MergeUI/MergeButton
@onready var swap: TextureRect = $SwapUI/Swap
@onready var swap_button: Button = $SwapUI/SwapButton


func _ready() -> void:
	input_manager.split_state_changed.connect(_on_split_changed)
	input_manager.merge_state_changed.connect(_on_merge_changed)
	input_manager.swap_state_changed.connect(_on_swap_changed)

	# Initialize UI state
	_on_split_changed(input_manager.can_split)
	_on_merge_changed(input_manager.can_merge)
	_on_swap_changed(input_manager.can_swap)
	
	input_manager.set_can_split(true)


func _on_split_changed(can_split: bool) -> void:
	if can_split:
		split_button.disabled = false
		split.self_modulate.a = 1
	else:
		split_button.disabled = true
		split.self_modulate.a = 0.25

func _on_merge_changed(can_merge: bool) -> void:
	if can_merge:
		merge_button.disabled = false
		merge.self_modulate.a = 1
	else:
		merge_button.disabled = true
		merge.self_modulate.a = 0.25

func _on_swap_changed(can_swap: bool) -> void:
	if can_swap:
		swap_button.disabled = false
		swap.self_modulate.a = 1
	else:
		swap_button.disabled = true
		swap.self_modulate.a = 0.25
