extends Node

const MENU_SCENE_PATH = "res://scenes/Menu.tscn"
const CREDITS_SCENE_PATH = "res://scenes/Credits.tscn"
const MAIN_SCENE_PATH = "res://scenes/Main.tscn"

func _OnStartGameButtonPressed():
	SceneSwitcher.SwitchToScene(MAIN_SCENE_PATH)

func _OnShowCreditsButtonPressed():
	SceneSwitcher.SwitchToScene(CREDITS_SCENE_PATH)
	
func _OnBackButtonPressed():
	SceneSwitcher.SwitchToScene(MENU_SCENE_PATH)
		
func _OnCloseGameButtonPressed():
	get_tree().quit()
