extends Area2D

export var time = 15.0

func _ready():
	pass


func _on_Bubble_body_entered(body):
	get_tree().call_group("power_up_bar" , "start" , time)
	body.bolha()
	queue_free()
