extends character_base

# @export var MAX_HEALTH: float = 10
# @export var SPEED: float = 10


@onready var attack1 = move.new()
# @onready var move_list: Array = []


func _ready():
	SPEED = 10
	MAX_HEALTH = 10
	health = MAX_HEALTH
	attack1.name = "Attack 1"
	attack1.damage = 5
	move_list.append(attack1)

