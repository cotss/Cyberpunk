extends Control

@export var login_state_label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.Auth.sw_session_check_complete.connect(_on_login_complete)
	SilentWolf.Auth.sw_login_complete.connect(_on_login_complete)
	SilentWolf.Auth.sw_logout_complete.connect(_on_logout_complete)
	
	SilentWolf.Auth.auto_login_player()

func _on_register_button_pressed():
	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Register.tscn")

func _on_login_button_pressed():
	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Login.tscn")

func _on_logout_button_pressed():
	SilentWolf.Auth.logout_player()
	
	
func _on_logout_complete(a, b):
	update_login_state_label()
		
func _on_login_complete(sw_result):
	update_login_state_label()
		
func update_login_state_label():
	if SilentWolf.Auth.logged_in_player:
		%LoginStateLabel.text = "Logged In"
	else:
		%LoginStateLabel.text = "Not Logged In"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
