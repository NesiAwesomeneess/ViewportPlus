extends Node2D
class_name ParallaxLayer2D

export (Vector2) var center_offset
export (float) var motion

func _ready():
	add_to_group("Parallax")
