extends CharacterBody2D

const speed = 30
var current_state = IDLE

var is_roaming = true
var is_chatting = false

var robot
var robot_in_chat_zone = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _process(delta):
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	else:
		current_state == 0 or current_state and !is_chatting
		$AnimatedSprite2D.play("idle")
		
	if Input.is_action_just_pressed("chat") and robot_in_chat_zone:
		print("chatting...")
		$Dialogue.start()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")

	

func _on_chat_detection_area_body_entered(body):
	if body.is_in_group("Robot"):
		robot_in_chat_zone = true
		

func _on_chat_detection_area_body_exited(body):
	if body.is_in_group("Robot"):
		robot_in_chat_zone = false


func _on_dialogue_dialogue_finished():
	is_chatting = false
	is_roaming = true
