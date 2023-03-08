extends Resource
class_name Player

@export var id: String: 
	set(p_val):
		id = p_val
		emit_changed()
@export var name: String: 
	set(p_val):
		name = p_val
		emit_changed()
@export var index: int: 
	set(p_val):
		if p_val == index: return
		index = p_val
		emit_changed()

func _init(p_id: String = "", p_name: String = "", p_index: int = 0):
	id = p_id
	name = p_name.to_upper()
	index = p_index
	
func save():
	ResourceSaver.save(self, Consts.SAVE_GROUPS_DIR + id + ".tres")
