extends CanvasLayer

@onready var anim_player = $AnimationPlayer
func _ready():
	anim_player.stop()
	$ColorRect.modulate.a = 0
	
	
