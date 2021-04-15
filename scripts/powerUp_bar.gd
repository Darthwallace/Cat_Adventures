extends Node2D

onready var size = $bar.rect_size #Define o tamanho da barra em caso de ajustes

func _ready():
	hide() # faz com o que a barra fique escondida
	add_to_group("power_up_bar")

func start(time):
	show()
	$Tween.interpolate_method(self , "count" , 1 , 0 , time , Tween.TRANS_LINEAR ,Tween.EASE_IN , 0)
	$Tween.start()

func stop():
	$Tween.stop_all()
	hide()

func count(val):
	$bar.rect_size = Vector2(size.x * val, size.y)


func _on_Tween_tween_completed(object, key):
	stop()
	get_tree().call_group("player" , "powerup_finished")
