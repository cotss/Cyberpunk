extends Area2D

@onready var game_manager = %"Game Manager"


func _on_body_entered(body):
	if (body.name == "Robot"):
		queue_free()
		game_manager.add_point()
