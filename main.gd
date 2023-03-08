extends Control

var main_menu = preload("res://scenes/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_margins()
	setup_dir()
	$MarginContainer.add_child(main_menu.instantiate())


#create a save dir if it doesn't exist
func setup_dir():
	var dir_exists = DirAccess.dir_exists_absolute(Consts.SAVE_GROUPS_DIR)
	if !dir_exists: DirAccess.make_dir_absolute(Consts.SAVE_GROUPS_DIR)
	
#deal with safe area/notch on mobile
func set_margins():
	if OS.get_name() != "iOS" and OS.get_name() != "Android": return
	var safe_area: Rect2i = DisplayServer.get_display_safe_area()
	var window_size: Vector2i = DisplayServer.screen_get_size()
	
	$MarginContainer.add_theme_constant_override("margin_top", safe_area.position.y)
	$MarginContainer.add_theme_constant_override("margin_bottom", 50)
	
