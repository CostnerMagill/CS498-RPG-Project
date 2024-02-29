extends Node


func goto_scene(scene_path: String) -> void:
	# Assuming you don't have a complex loading screen or animations for now
	var current_scene = get_tree().current_scene
	var next_scene = load(scene_path).instance()
	get_tree().current_scene = null
	get_tree().root.add_child(next_scene)
	get_tree().current_scene = next_scene
	if current_scene != null:
		current_scene.queue_free() # Free the old scene from memory
