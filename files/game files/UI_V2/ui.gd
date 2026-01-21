extends Control

const grayed_split = preload("res://files/game files/UI_V2/icons/grayed out split.png")
const grayed_merge = preload("res://files/game files/UI_V2/icons/grayed out merge.png")
const grayed_swap = preload("res://files/game files/UI_V2/icons/grayed out swap.png")
const split_texture = preload("res://files/game files/UI_V2/icons/split.png")
const merge_texture = preload("res://files/game files/UI_V2/icons/merge.png")
const swap_texture = preload("res://files/game files/UI_V2/icons/swap.png")


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
		split.texture = split_texture
	else:
		split_button.disabled = true
		split.texture = grayed_split

func _on_merge_changed(can_merge: bool) -> void:
	if can_merge:
		merge_button.disabled = false
		merge.texture = merge_texture
	else:
		merge_button.disabled = true
		merge.texture = grayed_merge

func _on_swap_changed(can_swap: bool) -> void:
	if can_swap:
		swap_button.disabled = false
		swap.texture = swap_texture
	else:
		swap_button.disabled = true
		swap.texture = grayed_swap
