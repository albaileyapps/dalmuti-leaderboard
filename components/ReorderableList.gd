extends ScrollContainer

var list_items: Array[PlayerListItem] = []
var item_rects: Array[Rect2] = []
const  spacing = 5

var is_dragging = false
var current_drag_index: int
var drag_item: PlayerListItem
var empty_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	get_v_scroll_bar().modulate.a = 0


func add_item(p_item: PlayerListItem):
	
	var y_pos = 0
	if list_items.size() > 0:
		y_pos += list_items[list_items.size() - 1].get_rect().position.y
		y_pos += list_items[list_items.size() - 1].get_rect().size.y
		y_pos += spacing
	p_item.position = Vector2(0, y_pos)
	%ListContainer.add_child(p_item)
	list_items.append(p_item)

#Need to call this to make scroll work properly - the ListContainer size has to be set manually to the accumulated size of its children
func calculate_size():
	%ListContainer.set_custom_minimum_size(Vector2(0, 0))
	var height = 0
	for item in list_items:
		height = height + item.get_rect().size.y
		height = height + spacing
	print("setting container size: ", height)
	%ListContainer.set_custom_minimum_size(Vector2(0, height))

func _process(delta):
	if is_dragging and drag_item != null:
			drag_item.position.y = $ListContainer.get_local_mouse_position().y - 30
			check_item_at_mouse_position()

func _input(event):
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			get_drag_item()
		else: 
			drop_item()
			
func check_item_at_mouse_position() -> int:
	for item in list_items:
		if item.get_global_rect().has_point(get_global_mouse_position()):
			if item.from_index != drag_item.from_index:
				reorder_item(item)
				return item.player.index
	return -1		
	
func reorder_item(item: PlayerListItem):
	var temp_empty_position = item.position
	item.to_index = drag_item.from_index
	drag_item.from_index = item.from_index
	drag_item.to_index = item.from_index
	item.tween_position(empty_position)
	empty_position = temp_empty_position

func get_drag_item():
	for item in list_items:
		if item.drag_handle_contains_mouse():
			is_dragging = true
			drag_item = item
			current_drag_index = item.player.index
			empty_position = item.position
			drag_item.z_index = 20
			set_auto_scroll(false)

func drop_item():
	if !is_dragging: return
	is_dragging = false
	drag_item.z_index = 0
	drag_item.tween_position(empty_position)
	drag_item = null
		
func check_adjacent_items():
	if current_drag_index > 0:
		var above = item_rects[current_drag_index - 1]
		if above.has_point(get_global_mouse_position()):
			print("MOVE ABOVE")
		print("global: ", get_global_mouse_position())
		print("local: ", get_local_mouse_position())
		print("above: ", above)
	if current_drag_index < item_rects.size() - 1:
		var below = item_rects[current_drag_index + 1]
#		print("below: ", below)
		
func set_auto_scroll(val: bool):
#	pass
	mouse_filter = Control.MOUSE_FILTER_PASS if val else Control.MOUSE_FILTER_IGNORE
#	vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO if val else ScrollContainer.SCROLL_MODE_DISABLED
		
func _on_list_container_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if !event.pressed:
			set_auto_scroll(true)
