extends "res://scenes/Scenebase.gd"

@onready var group_list_item = preload("res://components/GroupListItem.tscn")

const LIST_ITEM_GROUP = "group-list-item-group"
signal group_pressed(group: Group)

var groups: Array[Group] = []

func _ready():
	$VBoxContainer/NavBar.set_title("THE GREAT DALMUTI")
	fadables = [$VBoxContainer]
	_load_groups()
	_build_list()
	
func _load_groups():
	var dir = DirAccess.open(Consts.SAVE_GROUPS_DIR)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension() == "tres":
				var res = ResourceLoader.load(Consts.SAVE_GROUPS_DIR + file_name)
				if res is Group: 
					print("res is a group")
					groups.append(res)
				else:
					print("res is not a group")
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	groups.sort_custom(func(a, b): return a.name < b.name)

func _on_add_group_button_pressed():
	if %AddGroupLineEdit.text == "": return
	var group = Group.new(Utils.uuid(), %AddGroupLineEdit.text)
	groups.append(group)
	group.save()
	add_list_item(group)
	%AddGroupLineEdit.text = ""
	
func add_list_item(group: Group):
	var list_item = group_list_item.instantiate()
	list_item.add_to_group(LIST_ITEM_GROUP)
	list_item.setup(group)
	list_item.group_pressed.connect(_on_group_pressed)
	list_item.delete_group.connect(_on_delete_group_pressed)
	%GroupList.add_child(list_item)
	list_item.is_edit_mode = %EditModeButton.button_pressed
	
func _build_list():
	_remove_list_items()
	for group in groups:
		add_list_item(group)
		
func _remove_list_items():
	for child in %GroupList.get_children():
		child.queue_free()
	
func _on_group_pressed(p_group: Group):
	fade(0.0, transition_duration, 0.0)
	var scene = load("res://scenes/Leaderboard.tscn").instantiate()
	scene.setup(p_group)
	scene.exit.connect(_on_leaderboard_exit)
	add_child_scene(scene, transition_duration, transition_duration)
	
func _on_leaderboard_exit():
	fade(1.0, transition_duration, transition_duration)
	
func _on_delete_group_pressed(p_group: Group):
	groups.erase(p_group)
	DirAccess.remove_absolute(Consts.SAVE_GROUPS_DIR + p_group.id + ".tres")
	_build_list()
	

func _on_edit_mode_button_pressed():
	var edit_mode = %EditModeButton.button_pressed
	%AddGroupContainer.visible = edit_mode
	print("EDIT MODE: ", edit_mode)
	get_tree().call_group(LIST_ITEM_GROUP, "set", "is_edit_mode", edit_mode)
