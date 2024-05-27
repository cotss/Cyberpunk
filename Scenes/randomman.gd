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

func _ready():
	pass

func _process(delta):
	if robot_in_chat_zone:
		if Input.is_action_just_pressed("chat") and robot_in_chat_zone:
			run_rando_dialogue()
			
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")

func run_rando_dialogue():
	Dialogic.timeline_ended.connect(ended_dialogue)
	###############
	is_chatting = true
	is_roaming = false
	
	var dialogue_line = randi_range(1,6)
	Dialogic.start("random_chat_" + str(dialogue_line))
	##############
	
func ended_dialogue():
	Dialogic.timeline_ended.connect(ended_dialogue)
	is_chatting = false
	is_roaming = true

func _on_chatdetection_body_entered(body):
	if body.is_in_group("Robot"):
		robot_in_chat_zone = true


func _on_chatdetection_body_exited(body):
	if body.is_in_group("Robot"):
		robot_in_chat_zone = false

func run_dialogue(dialogue_string):
	is_chatting = true
	is_roaming = false
	
	Dialogic.start(dialogue_string)
	

