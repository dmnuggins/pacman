extends CanvasLayer

@export var score_manager: Node


func _ready():
	GameEvents.bit_consumed.connect(update_score)


func update_score(value: int):
	$%Score.text = str(score_manager.get_cur_score())
