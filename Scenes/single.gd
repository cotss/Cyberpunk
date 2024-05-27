extends CollisionShape2D

func _ready():
	add_to_group("single")

func _on_single_body_entered(body):
	if body.is_in_group("Robot"):
		get_tree().reload_current_scene()
