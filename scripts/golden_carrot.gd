extends Node2D

signal finished

func _ready():
	pass

func play():
	$anim.play("fade")
	yield($anim ,"animation_finished")
	emit_signal("finished")
