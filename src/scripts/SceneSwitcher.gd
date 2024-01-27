extends Node

var CurrentScene = null

func _ready():
	var root = get_tree().root
	CurrentScene = root.get_child(root.get_child_count() - 1)


func SwitchToScene(path):
	ResourceLoader.load_threaded_request(path)
	call_deferred("_DeferredSwitchToScene", path)


func _DeferredSwitchToScene(path):
	CurrentScene.free()

	var scene = ResourceLoader.load_threaded_get(path)
	CurrentScene = scene.instantiate()
	get_tree().root.add_child(CurrentScene)
	get_tree().current_scene = CurrentScene
