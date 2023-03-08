extends Control
class_name PlayerListItem

@onready var icon_no_dalmuti = preload("res://assets/img/icon-no-dalmuti.png")
@onready var icon_lesser_dalmuti = preload("res://assets/img/icon-lesser-dalmuti.png")
@onready var icon_great_dalmuti = preload("res://assets/img/icon-great-dalmuti.png")

var player: Player
var from_index: int
var to_index: int

var from_pos: Vector2
var to_pos: Vector2

var tween: Tween

signal delete_player(player: Player)

var is_edit_mode = false: 
	set(p_val):
		is_edit_mode = p_val
		%DragHandle.visible = !is_edit_mode
		%DeletePlayerButton.visible = is_edit_mode

func _ready():
	set_icon()

func setup(p_player: Player):
	player = p_player
	player.connect("changed", _on_player_changed)
	%PlayerNameLabel.text = player.name
	from_index = player.index
	to_index = player.index
	
	
func _on_player_changed():
	set_icon()
	
func set_icon():
	if player.index == 0: %Icon.texture = icon_great_dalmuti
	elif player.index == 1: %Icon.texture = icon_lesser_dalmuti
	else: %Icon.texture = icon_no_dalmuti
	
		
	
func drag_handle_contains_mouse() -> bool:
	return %DragHandle.get_global_rect().has_point(get_global_mouse_position())
	
func tween_position(p_pos: Vector2):
	if position == p_pos : return
	if tween != null: tween.kill()
	tween = create_tween().chain()
	var callback = func():
		from_index = to_index
	tween.tween_property(self, "position", p_pos, 0.1)
	tween.tween_callback(callback)
	
func _on_delete_player_button_pressed():
	print("delete player")
	emit_signal("delete_player", player)
