extends Node2D



func _ready():
	$"animação".play("walk")
	pass


func _on_body_body_entered(body):
	print("_on_body_body_entered")
	body.killed()

func _on_head_body_entered(body):
	$body.collision_mask = 0
	body.jump(600 , false)
	$hurt.play()
	$anim.play("destroy")
	yield($anim , "animation_finished")
	queue_free()
