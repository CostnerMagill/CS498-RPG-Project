extends Node2D

func _on_player_detector_body_entered(body):
	Events.room_entered.emit(self)



func _on_battle_area_body_entered(body):
	get_tree().change_scene_to_file("res://battle_scene.tscn")
