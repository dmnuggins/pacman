extends Area2D

@export var value := 10
signal bit_consumed


func _ready():
	self.body_entered.connect(on_body_entered)


func on_body_entered(other_body):
#	emit_signal("bit_consumed", value)
	GameEvents.emit_bit_consumed(value)
	queue_free()
