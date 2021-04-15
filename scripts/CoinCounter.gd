extends Node2D


var coins = 0 setget set_coin


func _ready():
	update_label()
	add_to_group("CoinCounter")
	pass

func pick_coin():
	self.coins += 1
	#update_label()

func update_label():
	$coins.text = str(coins)

func set_coin(val):
	coins = val
	update_label()
