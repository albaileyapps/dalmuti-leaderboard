extends "res://scenes/Scenebase.gd"

var groups: Groups
@onready var group_list_item = preload("res://components/GroupListItem.tscn")

const LIST_ITEM_GROUP = "list-item-group"
signal group_pressed(group: Group)

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
	list_item.add_to_group(LIST_ITEM_GROUP)
	list_item.setup(group)
	list_item.group_pressed.connect(_on_group_pressed)
	list_item.delete_group.connect()
	%GroupList.add_child(list_item)
	
func _build_list():
	print("building list: ", groups.list.size())
	for group in groups.list:
		add_list_item(group)
		
func _on_group_pressed(p_group: Group):
#	fade(0.0, transition_duration)
	var scene = load("res://scenes/Leaderboard.tscn").instantiate()
	scene.setup(p_group)
	add_child_scene(scene, transition_duration, 0.0)
	
func _on_delete_group_pressed(p_group: Group):
	print("DELETE GROUP")
	
