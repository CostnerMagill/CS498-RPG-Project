extends CharacterBody2D

@onready var progress_bar = $ProgressBar
@onready var _focus = $focus

@export var MAX_HEALTH: float = 10
@export var SPEED: float = 10

class move:
	var name: String
	var damage: int

@onready var attack1: move
@onready var move_list: Array = []

var health: float = 10:
	set(value):
		health = value
		_update_progress_bar()

func _ready():
	attack1.name = "Attack 1"
	attack1.damage = 5
	move_list.append(attack1)

func _update_progress_bar():
	progress_bar.value = (health/MAX_HEALTH) * 100

func focus():
	_focus.show()

func unfocus():
	_focus.hide()

func take_damage(value):
	health -= value
	_update_progress_bar()

func select_move():
	return move_list[0]
