extends Control
class_name PlayerListItem

var player: Player
var from_index: int
var to_index: int

var from_pos: Vector2
var to_pos: Vector2


var tween: Tween


func _ready():
	pass

func setup(p_player: Player):
	player = p_player
	%PlayerNameLabel.text = player.name
	from_index = player.index
	to_index = player.index
	
func drag_handle_contains_mouse() -> bool:
	return %DragHandle.get_global_rect().has_point(get_global_mouse_position())
	
func tween_position(p_pos: Vector2):
	if tween != null: tween.kill()
	tween = create_tween().chain()
	var callback = func():
		from_index = to_index
	tween.tween_property(self, "position", p_pos, 0.1)
	tween.tween_callback(callback)
	
