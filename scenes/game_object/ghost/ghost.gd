extends CharacterBody2D
class_name Ghost


@export var speed := 10
@export var player : Node2D
@export var grid: TileMap


@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var sprite_animator := $AnimatedSprite2D


var cur_dir: Vector2
var cur_grid_cell: Vector2: set = _set_cur_grid_cell, get = _get_cur_grid_cell

var path: set = _set_path, get = _get_path

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
#	print(player)
	nav_agent.radius = 16
#	print(grid)
	makepath()


func _physics_process(_delta: float) -> void:
#	var dir = to_local(nav_agent.get_next_path_position()).normalized()
#	path = nav_agent.get_current_navigation_path()
#	print((path[4] - position).normalized())
#	velocity = dir * speed
	var move_direction = (path[1] - cur_grid_cell)
	print(move_direction)
	velocity = move_direction * speed
	move_and_slide()


func _set_cur_grid_cell(cell: Vector2) -> void:
	cur_grid_cell = cell


func _get_cur_grid_cell() -> Vector2:
	return cur_grid_cell


func _set_path(new_path: PackedVector2Array) -> void:
	path = new_path

func _get_path():
	return path

func makepath() -> void:
	nav_agent.target_position = player.global_position


func _on_timer_timeout():
	makepath()
