extends CharacterBody2D


var SPEED = -30.0
var facing_right = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_alive = true

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var idle_timer = Timer.new()

var state = "walking" # Possible states: "walking", "idling"

func _ready():
	add_to_group("wheelchair")
	idle_timer.wait_time = 1.0 # Adjust the idle time as needed
	idle_timer.one_shot = true
	idle_timer.connect("timeout", Callable(self, "_on_idle_timer_timeout"))
	add_child(idle_timer)


func _physics_process(delta):
	if not is_alive:
		return
		
	if state == "walking":
		if not is_on_floor():
			velocity.y += gravity * delta
			
		if not $RayCast2D.is_colliding() and is_on_floor():
			flip()
		# Set the horizontal velocity to a constant negative value
		velocity.x = SPEED
		move_and_slide()
		
	update_animation()

func update_animation():
	if state == "walking":
		animated_sprite_2d.play("walk")
	elif state == "idling":
		animated_sprite_2d.play("idle")

func _on_hitbox_body_entered(body):
	if body.is_in_group("Robot"):
		queue_free()

func flip():
	state = "idling"
	velocity.x = 0
	idle_timer.start()

func _on_idle_timer_timeout():
	facing_right = !facing_right
	scale.x = abs(scale.x) * (1 if facing_right else -1)
	SPEED = abs(SPEED) * (1 if facing_right else -1)
	state = "walking"
