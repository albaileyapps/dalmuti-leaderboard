extends Panel

@export var show_close_button = true

signal close_pressed

func _ready():
	%CloseButton.visible = show_close_button

func set_title(p_title: String):
	%TitleLabel.text = p_title


func _on_close_button_pressed():
	emit_signal("close_pressed")
