extends "res://scenes/Scenebase.gd"

@onready var player_list_item = preload("res://components/PlayerListItem.tscn")
@onready var player_list = %ReorderableList

const LIST_ITEM_GROUP = "player-list-item-group"

var group: Group

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
	_remove_list_items()
	group.sort_players()

	for player in group.players:
		var list_item = player_list_item.instantiate()
		list_item.add_to_group(LIST_ITEM_GROUP)
		list_item.setup(player)
		list_item.is_edit_mode = %EditModeButton.button_pressed
		list_item.delete_player.connect(_on_delete_player)
		player_list.add_item(list_item)
		
func _remove_list_items():
	player_list.remove_all()
	
func _on_nav_bar_close_pressed():
	remove_from_parent_scene(transition_duration)
	emit_signal("exit")

func _on_reorderable_list_reordered():
	group.save()

func _on_edit_mode_button_pressed():
	var edit_mode = %EditModeButton.button_pressed
	print("Leaderboard edit mode: ", edit_mode)
	%AddPlayerContainer.visible = edit_mode
	%BottomButtonContainer.visible = edit_mode
	get_tree().call_group(LIST_ITEM_GROUP, "set", "is_edit_mode", edit_mode)

func _on_add_player_button_pressed():
	_add_player(%AddPlayerLineEdit.text)
	
func _on_add_player_line_edit_gui_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER and not event.echo:
		_add_player(%AddPlayerLineEdit.text)
	
func _add_player(p_name: String):
	if p_name == "": return
	var player = Player.new(Utils.uuid(), p_name, group.players.size())
	group.add_player(player)
	group.save()
	%AddPlayerLineEdit.text = ""
	_build_list()
	
func _on_delete_player(p_player: Player):
	group.remove_player(p_player)
	group.reset_indices()
	group.save()
	_build_list()


func _on_randomize_button_pressed():
	group.players.shuffle()
	for i in group.players.size():
		group.players[i].index = i
	_build_list()
	
