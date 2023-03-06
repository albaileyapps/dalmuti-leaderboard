extends Control

var group: Group
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setup(p_group: Group):
	group = p_group
	%Label.text = group.name
