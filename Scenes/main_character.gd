extends CharacterBody2D

var is_dying = false
var is_jumping = false

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var death_timer = $death_timer

const SPEED = 300.0
const JUMP_VELOCITY = -460.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	add_to_group("Robot")
	death_timer.connect("timeout", Callable(self, "_on_DeathTimer_timeout"))
	collision_shape_2d.connect("body_entered", Callable(self, "_on_hitbox_body_entered"))





func _physics_process(delta):
	if is_dying:
		return
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		is_jumping = false
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 50)
	update_animation(direction)
	move_and_slide()
	
func update_animation(direction):
	if is_dying:
		return
		
	if is_jumping:
		animated_sprite_2d.play("idle")
	elif direction !=0:
		animated_sprite_2d.flip_h = (direction < 0)
		animated_sprite_2d.play("run")
	else :
		animated_sprite_2d.play("idle")
	
	
	

func _on_hitbox_body_entered(body):
		if body.is_in_group("wheelchair"):
			die()
		elif body.is_in_group("spike"):
			die()
		elif body.is_in_group("single"):
			die()

func die():
	if is_dying:
		return
		
	is_dying = true
	animated_sprite_2d.play("die")
	await move_player_up_and_down()
	Global.player_lives -= 1
	
	if Global.player_lives > 0:
		print("Reloading Scene")
		get_tree().reload_current_scene()
	else:
		print("game over")
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
	
func move_player_up_and_down():
	var start_position = position
	var down_position = start_position + Vector2(0,50) #Reset of the scene depends on the down position traveled
		
	while position.y < down_position.y:
		position.y += 4
		await get_tree().create_timer(0.01).timeout
		
func on_DeathTimer_timeout():
	get_tree().reload_current_scene()




