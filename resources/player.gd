extends Resource
class_name Player

@export var id: int: 
	set(p_val):
		id = p_val
		emit_changed()
@export var name: String: 
	set(p_val):
		name = p_val
		emit_changed()
@export var index: int: 
	set(p_val):
		index = p_val
		emit_changed()

func _init(p_id: int = 0, p_name: String = "", p_index: int = 0):
	id = p_id
	name = p_name
	index = p_index
	
