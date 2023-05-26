extends CharacterBody2D
class_name Ghost


@export var speed := 75
@export var player : Node2D

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var sprite_animator := $AnimatedSprite2D

var cur_dir: Vector2

var path : set = _set_path, get = _get_path

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	nav_agent.radius = 16
	makepath()


func _physics_process(_delta: float) -> void:
#	var dir = to_local(nav_agent.get_next_path_position()).normalized()
#	path = nav_agent.get_current_navigation_path()
	print(path)
	
#	velocity = dir * speed
	move_and_slide()


func _set_path(new_path: PackedVector2Array) -> void:
	path = new_path

func _get_path():
	return path

func makepath() -> void:
	nav_agent.target_position = player.global_position


func _on_timer_timeout():
	makepath()
