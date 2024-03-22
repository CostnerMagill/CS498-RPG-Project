extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
func _ready():
	pass # Replace with function body.
@onready var _animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("ui_up"):
		_animated_sprite.play("RunForward")
	elif Input.is_action_pressed("ui_down"):
		_animated_sprite.play("RunBackward")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.play("RunLeft")
	elif Input.is_action_pressed("ui_right"):
		_animated_sprite.play("RunRight")
	else:
		_animated_sprite.stop()
