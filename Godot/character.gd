extends CharacterBody2D

@export var MAX_HEALTH: float
@export var SPEED: float
@export var IS_ALIVE: bool = true

@onready var progress_bar = $ProgressBar
@onready var _focus = $focus

class move:
    var damage: int
    var name: String

@onready var attack1 = move.new()
@onready var move_list: Array = []

var health: float = MAX_HEALTH:
    set(value):
        health = value
        _update_progress_bar()

func _ready():
    health = MAX_HEALTH
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
    if health <= 0:
        IS_ALIVE = false

func select_move():
    return move_list[0]
