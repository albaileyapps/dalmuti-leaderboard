extends Control

var groups: Groups
@onready var group_list_item = preload("res://components/GroupListItem.tscn")

func _ready():
	groups = load(Consts.SAVE_GROUPS_PATH)
	print(groups.list.size())
	print(groups is Groups)
	_build_list()


func _on_add_group_button_pressed():
	var group = Group.new(01, "my group")
	groups.add_group(group)
	groups.save()
	add_list_item(group)
	
func add_list_item(group: Group):
	print("Adding list item")
	var list_item = group_list_item.instantiate()
	list_item.setup(group)
	%GroupList.add_child(list_item)
	
func _build_list():
	print("building list: ", groups.list.size())
	for group in groups.list:
		add_list_item(group)
	
