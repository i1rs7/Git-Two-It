extends Control

@onready var split: TextureRect = $Split
@onready var merge: TextureRect = $Merge
@onready var split_button: Button = $SplitButton
@onready var merge_button: Button = $MergeButton

func _ready() -> void:
	Globals.split_state_changed.connect(_on_split_changed)
	Globals.merge_state_changed.connect(_on_merge_changed)

	# Initialize UI state
	_on_split_changed(Globals.can_split)
	_on_merge_changed(Globals.can_merge)
	
	Globals.set_can_split(true)


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
