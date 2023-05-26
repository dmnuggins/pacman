extends Area2D

@export var value := 10
signal power_ball_consumed


func _ready():
	self.body_entered.connect(on_body_entered)


func on_body_entered(other_body):
	emit_signal("power_ball_consumed", value)
	print("POWER_BALL")
	queue_free()
