extends Node

var can_split: bool = false
var can_merge: bool = false

signal split_state_changed(can_split: bool)
signal merge_state_changed(can_merge: bool)

func set_can_split(value: bool) -> void:
	if can_split == value:
		return
	can_split = value
	split_state_changed.emit(value)

func set_can_merge(value: bool) -> void:
	if can_merge == value:
		return
	can_merge = value
	merge_state_changed.emit(value)
