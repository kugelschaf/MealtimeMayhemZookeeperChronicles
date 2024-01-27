extends Node


const MAIN_SCENE_PATH = "res://scenes/Main.tscn"


func _OnStartGameButtonPressed():
	SceneSwitcher.SwitchToScene(MAIN_SCENE_PATH)
