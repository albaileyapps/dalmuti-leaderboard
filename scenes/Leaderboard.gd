extends "res://scenes/Scenebase.gd"

@onready var player_list_item = preload("res://components/PlayerListItem.tscn")
@onready var player_list = %ReorderableList

var group = Group.new(01, "UI5")

var is_dragging = false
var drag_parent: PlayerListItem
var drag_child: Control

# Called when the node enters the scene tree for the first time.
func _ready():

	get_node("%NavBar").set_title(group.name)
	_build_list()
	player_list.calculate_size()
	
func setup(p_group: Group):
	group = p_group
	
func _build_list():
	for player in group.players:
		var list_item = player_list_item.instantiate()
		list_item.setup(player)
		player_list.add_item(list_item)
	
func _process(delta):
	pass


func _on_gui_input(event):
	pass


func _on_nav_bar_close_pressed():
	remove_from_parent_scene(transition_duration)

func _on_reorderable_list_reordered():
	pass # Replace with function body.
