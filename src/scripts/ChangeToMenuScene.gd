extends Timer


const MENU_SCENE_PATH = "res://scenes/Menu.tscn"


func _OnTimeout():
	SceneSwitcher.SwitchToScene(MENU_SCENE_PATH)
