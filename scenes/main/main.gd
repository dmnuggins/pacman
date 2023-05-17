extends Node

var current_score = 0
var high_score = 0

func _on_entrance_left_body_entered(body):
	if body is PacMan || body is Ghost:
		body.teleport_to($ExitRight.global_position)


func _on_entrance_right_body_entered(body):
	if body is PacMan || body is Ghost:
		body.teleport_to($ExitLeft.global_position)
