extends CanvasLayer

# Popup text and button labels
var question_text := "Do you want to send the warning message to others?"
var yes_text := "Send warning"
var no_text := "Do nothing"

# Nodes
var warning_panel: Panel
var label: Label
var ok_button: Button
var cancel_button: Button

func _ready():
	# --- Create the Panel ---
	warning_panel = Panel.new()
	warning_panel.set_custom_minimum_size(Vector2(300, 120))  # panel size
	add_child(warning_panel)
	
	# Center the panel
	var viewport_size = get_viewport().get_visible_rect().size
	warning_panel.position = (viewport_size - warning_panel.get_minimum_size()) / 2
	
	# Set panel color (semi-transparent)
	warning_panel.add_theme_color_override("panel", Color(0, 0, 0, 0.7))
	
	# --- Create the Label ---
	label = Label.new()
	label.text = question_text
	label.set_custom_minimum_size(Vector2(280, 60))  # width controls wrapping
	label.position = Vector2(10, 10)
	label.add_theme_color_override("font_color", Color.WHITE)
	# no autowrap needed
	warning_panel.add_child(label)

	
	# --- Create OK Button ---
	ok_button = Button.new()
	ok_button.text = yes_text
	ok_button.set_custom_minimum_size(Vector2(120, 30))
	ok_button.position = Vector2(20, 80)
	ok_button.pressed.connect(Callable(self, "_on_warning_confirmed"))
	warning_panel.add_child(ok_button)
	
	# --- Create Cancel Button ---
	cancel_button = Button.new()
	cancel_button.text = no_text
	cancel_button.set_custom_minimum_size(Vector2(120, 30))
	cancel_button.position = Vector2(160, 80)
	cancel_button.pressed.connect(Callable(self, "_on_warning_canceled"))
	warning_panel.add_child(cancel_button)
	
	# Show the popup
	warning_panel.show()


# --- Button callbacks ---
func _on_warning_confirmed():
	print("Player chose to send the warning!")
	warning_panel.hide()
	# Trigger additional logic here


func _on_warning_canceled():
	print("Player chose to do nothing.")
	warning_panel.hide()
