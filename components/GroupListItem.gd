extends Control

var group: Group
var touch_down_time: int
var touch_down_pos: Vector2

var is_edit_mode = false: 
	set(p_val):
		is_edit_mode = p_val
		%ArrowRight.visible = !is_edit_mode
		%DeleteGroupButton.visible = is_edit_mode

signal group_pressed(group: Group)
signal delete_group(group: Group)

func _ready():
	is_edit_mode = false

func setup(p_group: Group):
	group = p_group
	%Label.text = group.name

func _on_gui_input(event):
	if !event is InputEventMouseButton: return
	if event.button_index != MOUSE_BUTTON_LEFT: return
	if event.pressed:
		print("touch down")
		touch_down_time = Time.get_ticks_msec()
		touch_down_pos = get_global_mouse_position()
	else:
		if Time.get_ticks_msec() - touch_down_time > 800: return
		if touch_down_pos.distance_to(get_global_mouse_position()) > 10: return
		emit_signal("group_pressed", group)
		
func _on_delete_group_button_pressed():
	emit_signal("delete_group", group)
