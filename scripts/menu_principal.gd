extends Node

var game = preload("res://scenes/Game.tscn")

func _ready():
	pass
	
func _on_Button_pressed():
		get_tree().change_scene("res://scenes/Game.tscn")

func _on_sair_pressed():
	$sair/Label.visible = true
	$sair/select3.play()
	

func _on_Yes_pressed():
	$sair/select3.play()
	get_tree().quit()

func _on_No_pressed():
	$sair/Label.hide()
	$sair/select3.play()
