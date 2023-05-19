extends Area2D
class_name HurtBoxComponent

func _ready():
	area_entered.connect(on_area_entered)


func on_area_entered(other_area):
	if not other_area is HitBoxComponent:
		return
	
	var hitbox_component = other_area as HitBoxComponent
	
