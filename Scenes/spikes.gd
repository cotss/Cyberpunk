extends CharacterBody2D

func _ready():
	add_to_group("spike")

func _on_body_entered(body):
	if body.is_in_group("Robot"):
		get_tree().reload_current_scene()
