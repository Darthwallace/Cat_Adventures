tool
extends ParallaxBackground

export(Color) var modulate_L1 = Color(1,1,1,1) setget set_modulate_L1
export(Color) var modulate_L2 = Color(1,1,1,1) setget set_modulate_L2
export(Color) var modulate_L3 = Color(1,1,1,1) setget set_modulate_L3
export(Color) var modulate_L4 = Color(1,1,1,1) setget set_modulate_L4

func _ready():
	set_colors()
	pass


func set_modulate_L1(val):
	modulate_L1 = val
	if is_inside_tree() && Engine.editor_hint:
		set_colors()

func set_modulate_L2(val):
	modulate_L2 = val
	if is_inside_tree() && Engine.editor_hint:
		set_colors()

func set_modulate_L3(val):
	modulate_L3 = val
	if is_inside_tree() && Engine.editor_hint:
		set_colors()

func set_modulate_L4(val):
	modulate_L4 = val
	if is_inside_tree() && Engine.editor_hint:
		set_colors()

func set_colors():
	$layer1/bg_layer1.modulate = modulate_L1
	$Layer2/bg_layer2.modulate = modulate_L2
	$Layer3/bg_layer3.modulate = modulate_L3
	$Layer4/bg_layer4.modulate = modulate_L4
