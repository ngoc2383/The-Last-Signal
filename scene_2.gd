extends Node2D

@onready var warning_instance = $Warning  # instance of warning.tscn
@onready var warning_panel: Panel = warning_instance.get_node("WarningPanel")  # change node name in scene

@onready var ok_button: Button = warning_panel.get_node("OKButton")
@onready var cancel_button: Button = warning_panel.get_node("CancelButton")
@onready var label: Label = warning_panel.get_node("Label")

func _ready():
	# Debugging
	print("WarningPanel found? ->", warning_panel)
	if not warning_panel:
		print("ERROR: Could not find nodes! Check paths.")
		return

	# Set custom size for pixel-art UI
	warning_panel.set_custom_minimum_size(Vector2(300, 150))
	
	# Center the panel
	var viewport_size = get_viewport().get_visible_rect().size
	warning_panel.position = (viewport_size - warning_panel.get_minimum_size()) / 2

	# Set texts
	label.text = "Do you want to send the warning message to others?"
	ok_button.text = "Send warning"
	cancel_button.text = "Do nothing"

	# Connect button signals safely
	if not ok_button.pressed.is_connected(_on_warning_confirmed):
		ok_button.pressed.connect(Callable(self, "_on_warning_confirmed"))
	if not cancel_button.pressed.is_connected(_on_warning_canceled):
		cancel_button.pressed.connect(Callable(self, "_on_warning_canceled"))

	# Show panel immediately for testing
	warning_panel.show()


func _on_warning_confirmed():
	print("Player chose to send the warning!")
	warning_panel.hide()
	# Trigger next logic here


func _on_warning_canceled():
	print("Player chose to do nothing.")
	warning_panel.hide()
