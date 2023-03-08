extends Control
class_name Scenebase

const transition_duration = 0.3

var fadables: Array[Node] = []
signal exit

func fade(p_to: float, p_duration: float, p_delay: float):
	var tween = create_tween()
	tween.tween_interval(p_delay)
	for fadable in fadables:
		tween.tween_property(fadable, "modulate:a", p_to, p_duration)

func add_child_scene(p_scene: Scenebase, p_duration: float, p_delay: float):
	p_scene.modulate.a = 0
	add_child(p_scene)
	var tween = create_tween()
	tween.tween_interval(p_delay)
	tween.tween_property(p_scene, "modulate:a", 1.0, p_duration)
	
func remove_child_scene(p_scene: Scenebase):
	pass
	
func remove_from_parent_scene(p_duration):
	print("remove from parent scene")
	var tween = create_tween().chain()
	tween.tween_property(self, "modulate:a", 0.0, p_duration)
	tween.tween_callback(queue_free)
	


