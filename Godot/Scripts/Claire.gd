extends CharacterBody2D

const SPEED = 120.0

@onready var sprite = $AnimatedSprite2D
var last_direction = "Down"

func _physics_process(delta):
	var input_direction = _get_input_direction()
	velocity = input_direction * SPEED
	if velocity != Vector2.ZERO:
		set_sprite_direction(input_direction)
		move_and_slide()
	else:
		sprite.play(last_direction) 

func set_sprite_direction(input_direction):
	var animation_name = "South"  # Default animation
	if input_direction.x < 0:
		animation_name = "West"
		last_direction = "Left"
	elif input_direction.x > 0:
		animation_name = "East"
		last_direction = "Right"
	if input_direction.y < 0:
		animation_name = "North"
		last_direction = "Up"
	elif input_direction.y > 0:
		animation_name = "South"
		last_direction = "Down"
	
	if sprite.animation != animation_name:
		sprite.play(animation_name)

func _get_input_direction():
	var x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	var y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
	return Vector2(x, y).normalized()
