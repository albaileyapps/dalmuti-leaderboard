extends Node2D

var main_menu = preload("res://scenes/MainMenu.tscn")

const saved_groups_path = "user://"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_groups()
	$CanvasLayer.add_child(main_menu.instantiate())


func load_groups():
	var saved_groups = ResourceLoader.load(Consts.SAVE_GROUPS_PATH)
	if saved_groups == null:
		print("NO SAVED GROUPS")
		var groups = Groups.new()
		groups.save()
	else: 
		print("LOADED SOME GROUPS")
