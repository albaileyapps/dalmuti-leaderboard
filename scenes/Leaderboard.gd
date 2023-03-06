extends Control

@onready var player_list_item = preload("res://components/PlayerListItem.tscn")
@onready var player_list = %ReorderableList

var group = Group.new(01, "UI5")

var is_dragging = false
var drag_parent: PlayerListItem
var drag_child: Control

# Called when the node enters the scene tree for the first time.
func _ready():
#testing
	for i in 20:
		group.add_player(Player.new(i, str(i), i))
	
	get_node("%NavBar").set_title(group.name)
	_build_list()
	player_list.calculate_size()
	
func _build_list():
	for player in group.players:
		var list_item = player_list_item.instantiate()
		list_item.setup(player)
		player_list.add_item(list_item)
	
func _process(delta):
	pass


func _on_gui_input(event):
	pass
