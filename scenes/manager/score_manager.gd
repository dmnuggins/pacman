extends Node

var current_score = 0
var high_score = 0

func _ready():
	GameEvents.bit_consumed.connect(on_bit_consumed)
	

func update_cur_score(value: int):
	current_score += value

func get_cur_score() -> int:
	return current_score

func on_bit_consumed(value: int):
	update_cur_score(value)
