extends Node

@onready var player : PacMan = $PacMan
@onready var grid = $Grid
@onready var red: Ghost = $Red
@onready var path = $Path

var astar_grid: AStarGrid2D
var start_cell: Vector2i
var end_cell: Vector2i

var current_score = 0
var high_score = 0


func _ready():
	_init_grid()
	_update_grid_from_tilemap()
	find_path()


func _process(delta):
	find_path()


# Create an AStarGrid2D instance from the size of the game map
# Note that fundamental changes like size and cell_size require
# calling update() on the grid before it is usable
func _init_grid() -> void:
	astar_grid = AStarGrid2D.new()
	astar_grid.size = grid.get_used_rect().size
	astar_grid.default_compute_heuristic = 1
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
#	print("size: ", astar_grid.size)
	astar_grid.cell_size = grid.tile_set.tile_size
#	print("cell_size: ", astar_grid.cell_size)
	astar_grid.update()
	

# Look up each grid cell in our AStarGrid2D instance
# and set it to solid based on whether or not it is a wall in the game map
func _update_grid_from_tilemap() -> void:
	for i in range(astar_grid.size.x):
		for j in range(astar_grid.size.y):
			var id = Vector2i(i,j)
			
			if grid.get_cell_source_id(0, id) >= 0:
				var tile_type = grid.get_cell_tile_data(0, id).get_custom_data('tile_type')
				astar_grid.set_point_solid(Vector2i(i,j), tile_type == 'wall')
				
			else:
				astar_grid.set_point_solid(Vector2i(i,j), true)



func find_path() -> void:
	path.clear()
	# player position is several cells off based on the local_to_map conversion
	start_cell = grid.local_to_map(red.position)
	# passes ghost grid cell vector to ghost script for reference of cur_location on map (local)
	red.cur_grid_cell = start_cell
#	print(start_cell)
#	print("Player: ", start_cell)
	end_cell = grid.local_to_map(player.position)
#	print("Ghost: ", end_cell)

	if start_cell == end_cell or !astar_grid.is_in_boundsv(start_cell) or !astar_grid.is_in_boundsv(end_cell):
		return
	
	var id_path = astar_grid.get_id_path(start_cell, end_cell)
	# passes path to ghost script for move vector calculation
	red.path = id_path

#	print((id_path[1] - start_cell))
	for id in id_path:
		path.set_cell(0, id, 1, Vector2(0, 0))


func _on_entrance_left_body_entered(body):
	if body is PacMan || body is Ghost:
		body.teleport_to($ExitRight.global_position)


func _on_entrance_right_body_entered(body):
	if body is PacMan || body is Ghost:
		body.teleport_to($ExitLeft.global_position)
