extends Button


func _ready():
	pass


func _on_help_pressed():
		$TextEdit.visible = true
		$exit.visible = true
		$select2.play()

func _on_Button_pressed():
	$TextEdit.hide()
	$exit.hide()
	$select2.play()



