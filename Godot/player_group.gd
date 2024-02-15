extends Node2D

var players: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_children()
	
	for i in players.size():
		players[i].position = Vector2(0, i*200)


