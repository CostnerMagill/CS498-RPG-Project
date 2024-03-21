extends CharacterBody2D

@onready var progress_bar = $ProgressBar
@onready var _focus = $focus

@export var MAX_HEALTH: float = 10
@export var SPEED: float = 2


var health: float = 10:
	set(value):
		health = value
		_update_progress_bar()

func _update_progress_bar():
	progress_bar.value = (health/MAX_HEALTH) * 100

func focus():
	_focus.show()

func unfocus():
	_focus.hide()

func take_damage(value):
	health -= value
	_update_progress_bar()
