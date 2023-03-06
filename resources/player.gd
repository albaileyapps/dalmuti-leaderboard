extends Resource
class_name Player

@export var id: int
@export var name: String
@export var index: int

func _init(p_id: int = 0, p_name: String = "", p_index: int = 0):
	id = p_id
	name = p_name
	index = p_index
	
