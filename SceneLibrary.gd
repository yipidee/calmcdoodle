extends Node

signal moved

func load_scene(scene_id):
	get_child(scene_id).load_scene(scene_id)

func _on_moved(next_scene_id):
	print(next_scene_id)
	emit_signal("moved", next_scene_id)
