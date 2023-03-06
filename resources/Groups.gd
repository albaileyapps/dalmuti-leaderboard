extends Resource
class_name Groups

@export var list: Array[Group] = []

func _init(plist: Array[Group] = []):
	list = plist

func add_group(group: Group):
	list.append(group)
	
func save():
	print("saving groups")
	ResourceSaver.save(self, Consts.SAVE_GROUPS_PATH)
