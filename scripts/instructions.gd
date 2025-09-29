extends CanvasLayer

@onready var instructions = $Label
@onready var anim_player = $AnimationPlayer2

var instructions_done: bool = false

func _ready():
	# Start invisible
	instructions.modulate.a = 0
	instructions.visible = true
	anim_player.play("fade_in")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and not instructions_done:
		instructions_done = true
		anim_player.play("fade_out")
		await anim_player.animation_finished
		# Hide the instructions after fade out
		instructions.visible = false
		# Optionally, enable gameplay or next scene here
