extends Node


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")



func _on_logout_button_pressed():
	SilentWolf.Auth.logout_player()
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
