extends CharacterBody2D
class_name PacMan

@export var speed := 100
@export var move_direction := Vector2.ZERO

@onready var sprite_animator := $AnimatedSprite2D

signal died

var next_dir: String
var cur_dir: String

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

var clear_player: bool = true
var clear_up: bool = true
var clear_right: bool = true
var clear_left: bool = true
var clear_down: bool = true
var can_move: bool = true

var vision: Array[RayCast2D]


func _ready():
	connect_signals()
	initialize_vision()
	cur_dir = "left"
	move_direction = inputs["left"]
	sprite_animator.play("h_move")
	sprite_animator.flip_h = true


func _physics_process(delta):
	if can_move:
		get_input() # get user input
		if next_dir != cur_dir: # check if input is not cur_dir
			if is_input_valid():
				move_direction = inputs[next_dir]
				cur_dir = next_dir
				update_animation()
			
		if is_hitting_wall(cur_dir):
			move_direction = Vector2(0,0)
			sprite_animator.stop()

	velocity = move_direction * speed
	if get_slide_collision_count() > 0:
		velocity = Vector2.ZERO
	move_and_slide()


func connect_signals():
	$TopWallCollider.body_entered.connect(on_up_entered)
	$BotWallCollider.body_entered.connect(on_down_entered)
	$LeftWallCollider.body_entered.connect(on_left_entered)
	$RightWallCollider.body_entered.connect(on_right_entered)
	$TopWallCollider.body_exited.connect(on_up_exited)
	$BotWallCollider.body_exited.connect(on_down_exited)
	$LeftWallCollider.body_exited.connect(on_left_exited)
	$RightWallCollider.body_exited.connect(on_right_exited)


func update_animation():
	match cur_dir:
		"left":
			sprite_animator.play("h_move")
			sprite_animator.flip_h = true
		"right":
			sprite_animator.play("h_move")
			sprite_animator.flip_h = false
		"up":
			sprite_animator.play("v_move")
			sprite_animator.flip_v = false
		"down":
			sprite_animator.play("v_move")
			sprite_animator.flip_v = true
	# need to account for not moving to stop the animation


func initialize_vision():
	for child in get_children():
		if child.is_in_group("rays"):
			vision.append(child)


func get_input():
	for input in inputs:
		if Input.is_action_pressed(input):
			next_dir = input


# checks if the next input is valid
func is_input_valid():
	if next_dir == "up":
		if cur_dir != "up" && clear_up:
			return true
	
	elif next_dir == "down":
		if cur_dir != "down" && clear_down:
			return true

	elif next_dir == "left":
		if cur_dir != "left" && clear_left:
			return true

	elif next_dir == "right":
		if cur_dir != "right" && clear_right:
			return true
	return false


# given current direciton, check if pacman is colliding with a wall
func is_hitting_wall(current_direction: String):
	match current_direction:
		"up":
			if $Up.is_colliding():
				return true
		"down":
			if $Down.is_colliding():
				return true
		"right":
			if $Right.is_colliding():
				return true
		"left":
			if $Left.is_colliding():
				return true
	return false


func teleport_to(new_pos: Vector2):
	global_position = new_pos


func on_up_entered(other_body):
	clear_up = false


func on_down_entered(other_body):
	clear_down = false


func on_left_entered(other_body):
	clear_left = false


func on_right_entered(other_body):
	clear_right = false


func on_up_exited(other_body):
	clear_up = true


func on_down_exited(other_body):
	clear_down = true


func on_left_exited(other_body):
	clear_left = true


func on_right_exited(other_body):
	clear_right = true


