extends Resource
class_name Groups

@export var list: Array[Group] = []

func _init(plist: Array[Group] = []):
	list = plist

func add_group(p_group: Group):
	list.append(p_group)
	emit_changed()

func remove_group(p_group: Group):
	list.erase(p_group)
	emit_changed()
	
func save():
	ResourceSaver.save(self, Consts.SAVE_GROUPS_PATH)
