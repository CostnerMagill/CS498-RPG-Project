extends Node2D

var enemies: Array = []
var action_queue: Array = []
var is_battling: bool = false
var index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	enemies = get_children()
	
	for i in enemies.size():
		enemies[i].position = Vector2(0, i*200)

	enemies[0].focus()

func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		if index > 0:
			index -= 1
			switch_focus(index, index+1)
	if Input.is_action_just_pressed("ui_down"):
		if index < enemies.size() - 1:
			index += 1
			switch_focus(index, index-1)
	if Input.is_action_just_pressed("ui_accept"):
		action_queue.push_back(index)

	if action_queue.size() == enemies.size() and not is_battling:
		is_battling = true
		_action(action_queue)

func _action(stack):
	for i in stack:
		enemies[i].take_damage(2)
		await get_tree().create_timer(1).timeout
	action_queue.clear()
	is_battling = false

func switch_focus(x, y):
	enemies[x].focus()
	enemies[y].unfocus()
