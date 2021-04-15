tool
extends StaticBody2D

var textures = [
	"res://bunnyrunner_files/sprites/Environment/ground_grass_small.png",
	"res://bunnyrunner_files/sprites/Environment/ground_cake_small.png",
	"res://bunnyrunner_files/sprites/Environment/ground_sand_small.png",
	"res://bunnyrunner_files/sprites/Environment/ground_stone_small.png",
	"res://bunnyrunner_files/sprites/Environment/ground_wood_small.png",
	]
	

export(int ,"GRASS_SMALL" , "CAKE_SMALL" , "SAND_SMALL" , "STONE_SMALL" , "WOOD_SMALL") var texture = 0 setget set_texture

func _ready():
	pass
	
func _draw():
	$sprite.texture = load(textures[texture])

func set_texture(val):
	texture = val
	if is_inside_tree() && Engine.editor_hint:
		update()
	
	
	
	
	
	
	
	
