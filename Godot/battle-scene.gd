extends Node2D


@onready var player_group = $player_group
@onready var enemy_group = $enemy_group
var enemies: Array = []
var players: Array = []
var action_queue: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	print("What")
	players = player_group.players;
	enemies = enemy_group.enemies;
	for i in players.size():
		print(players[i].name)
	for i in enemies.size():
		print(enemies[i].name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


