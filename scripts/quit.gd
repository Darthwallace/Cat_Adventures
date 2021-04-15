extends Button


func _ready():
	pass


func _on_quit_pressed():
	#get_tree().quit()
	$Label.visible = true
	$select2.play()


func _on_Yes_pressed():
	$select2.play()
	get_tree().quit()

func _on_No_pressed():
	$Label.hide()
	$select2.play()
