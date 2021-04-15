extends Area2D


export var time = 10.0

func _ready():
	pass


func _on_jetpack_body_entered(body):
	get_tree().call_group("power_up_bar" , "start" , time)
	body.flutuar()
	queue_free()

