extends Node2D


@onready var player_group = $player_group
@onready var enemy_group = $enemy_group
var enemies: Array = []
var players: Array = []
var characters: Array = []
var action_queue: Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	players = player_group.players
	enemies = enemy_group.enemies
	characters.append_array(enemies)
	characters.append_array(players)
	characters.sort_custom(speed_sort)
	battle_logic()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Custom sort based on speed of characters
func speed_sort(a, b):
	return a.SPEED > b.SPEED

func battle_logic():
	select_player_moves()

func select_player_moves():
	for i in players.size():
		players[i].focus()
		var target: int = select_enemy_target()

func select_enemy_target():


