tool
extends Area2D

var textures = [
	"res://bunnyrunner_files/sprites/Environment/spike_top.png" ,
	"res://bunnyrunner_files/sprites/Environment/spike_bottom.png" ,
]

export(int , "Top" , "Botton") var texture = 0 setget set_texture

func _ready():
	pass

func _draw():
	$sprite.texture = load(textures[texture])
	

func set_texture(val):
	texture = val
	if is_inside_tree() and Engine.editor_hint:
		update()

func _on_spike_body_entered(body):
	body.killed()
	
