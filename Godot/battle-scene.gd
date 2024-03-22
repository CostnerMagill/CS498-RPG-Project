extends Node2D

@onready var player_group = $player_group
@onready var enemy_group = $enemy_group
var enemies: Array = []
var players: Array = []
var characters: Array = []
var action_queue: Array = []

var index_player: int = 0
var enemy_index: int = 0
var target_index_array: Array = []

var in_battle: bool = true
var pruning: bool = false
var selecting_target: bool = true 
var selecting_moves: bool = false 
var selecting_enemy_moves: bool = false 
var attacking: bool = false 

# class move:
#     var name: String
#    var damage: int

class action:
    var attack
    var target_index: int

# Get list of enemies and players, place them both in character array, then
# order them by speed for the fight, then resize action queue to the size of
# the character array since we write to the positions arbitrarily and not
# appending
func _ready():
    players = player_group.players
    enemies = enemy_group.enemies
    characters.append_array(enemies)
    characters.append_array(players)
    characters.sort_custom(speed_sort)
    action_queue.resize(characters.size())
    enemies[0].focus()
    battle_logic()
    
    
func _process(delta):
    if in_battle:
        if pruning:
            prune_character_arrays()
        if selecting_target:
            select_enemy_target()
        if selecting_moves:
            select_player_moves(target_index_array)
        if selecting_enemy_moves:
            select_enemy_moves()
        if attacking:
            perform_attacks()
    if !in_battle:
        print("Battle Over")

# Custom sort based on speed of characters
func speed_sort(a, b):
    return a.SPEED > b.SPEED

# Calls the main functions for the battle logic
func battle_logic():
    pass

# Loop through each player, select target and move
func select_player_moves(targets):
    for i in players.size():
        players[i].focus()
        var player_index: int = characters.find(players[i])
        var target: int = targets[i]
        var selected_move = players[i].select_move()
        var temp_action = action.new()
        temp_action.attack = selected_move
        temp_action.target_index = target
        action_queue[player_index] = temp_action
        players[i].unfocus()
        selecting_moves = false
        selecting_enemy_moves = true
    

# Visually select target for current player
func select_enemy_target():
    if Input.is_action_just_pressed("ui_up"):
        if enemy_index > 0:
            enemy_index -= 1
            switch_focus(enemy_index, enemy_index+1)
    if Input.is_action_just_pressed("ui_down"):
        if enemy_index < enemies.size() - 1:
            enemy_index += 1
            switch_focus(enemy_index, enemy_index-1)
    if Input.is_action_just_pressed("ui_accept"):
        target_index_array.append(enemy_index)
    if target_index_array.size() >= players.size():
        selecting_target = false
        selecting_moves = true
        

# Loop through each enemy, then select a move and a random target
func select_enemy_moves():
    var target_array: Array = []
    for i in players.size():
        target_array.append(characters.find(players[i]))
    for i in enemies.size():
        var enemy_index: int = characters.find(enemies[i])
        var enemy_move = enemies[i].select_move()
        var target: int = randi() % target_array.size()
        var temp_action = action.new()
        temp_action.attack = enemy_move
        temp_action.target_index = target
        action_queue[enemy_index] = temp_action
        selecting_enemy_moves = false
        attacking = true

func perform_attacks():
    for i in characters.size():
        if characters[i].IS_ALIVE == true:
            var target_index: int = action_queue[i].target_index
            if characters[target_index].IS_ALIVE == true:
                var damage: int = action_queue[i].attack.damage
                characters[target_index].take_damage(damage)
            else:
                print("Attack Failed")
        attacking = false
        pruning = true
        is_battle_over()

func is_battle_over():
    if players.is_empty():
        in_battle = false
    if enemies.is_empty():
        in_battle = false

# remove characters from their respective arrays if dead. Do it in reverse to
# avoid array index out of bounds
func prune_character_arrays():
    for i in range(enemies.size()-1, -1, -1):
        if enemies[i].IS_ALIVE == false:
            enemies.remove_at(i)
    for i in range(players.size()-1, -1, -1):
        if players[i].IS_ALIVE == false:
            players.remove_at(i)
    for i in range(characters.size()-1, -1, -1):
        if characters[i].IS_ALIVE == false:
            characters.remove_at(i)
    pruning = false
    selecting_target = true

func switch_focus(x, y):
    enemies[x].focus()
    enemies[y].unfocus()