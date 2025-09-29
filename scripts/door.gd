extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var door_opened: bool = false  # Track if the door has already opened

func _on_area_2d_body_entered(body: Node2D) -> void:
	if door_opened:
		return  # Already opened, do nothing

	if body.name == "player":
		door_opened = true
		animated_sprite.play("open")
		await animated_sprite.animation_finished
		# Defer disabling the collision so physics is not being flushed
		var area = $Area2D
		if area and area.has_node("CollisionShape2D"):
			area.get_node("CollisionShape2D").set_deferred("disabled", true)

		# Trigger fade (fix path issue below)

		door_opened = true  # Prevent further triggers
		
		# Fade
		var fade_layer = get_node("/root/Game/FadeLayer")  # path to FadeLayer
		var anim_player = fade_layer.get_node("AnimationPlayer")  # the AnimationPlayer node for fade out
		anim_player.stop()  # stop anything already playing
		anim_player.play("fade_out")  # play the fade_out animation inside that node
		await anim_player.animation_finished

		# Change to new scene
		get_tree().change_scene_to_file("res://scene/scene2.tscn")
		
		anim_player.play("fade_in")
		await anim_player.animation_finished
