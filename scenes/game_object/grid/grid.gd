extends TileMap
class_name Grid

var grid: Dictionary = {}

@onready var pf: Pathfinder = get_node('Pathfinder')

signal tileSelected(pos)

@export var show_debug: bool = false

