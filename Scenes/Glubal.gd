extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.configure({
		"api_key": "BuUpoANY8W5uopdHWoChv8UjDN39tLV23jeQEaOv",
		"game_id": "cyberpunk",
		"log_level": 1
  	})
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/main_menu.tscn"
  	})
	SilentWolf.configure_auth({
		"redirect_to_scene": "res://Scenes/main_menu.tscn",
		"login_scene": "res://addons/silent_wolf/Auth/Login.tscn",
		"email_confirmation_scene": "res://addons/silent_wolf/Auth/ConfirmEmail.tscn",
		"reset_password_scene": "res://addons/silent_wolf/Auth/ResetPassword.tscn",
		"session_duration_seconds": 0,
		"saved_session_expiration_days": 30
	})
