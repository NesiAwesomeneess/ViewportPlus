extends Node2D

export (NodePath) var camera_path
onready var camera : Camera2D = get_node(camera_path)

func _ready():
	var _position = camera.get_camera_screen_center()
	global_position = _position

func _process(delta):
	var _position = camera.get_camera_screen_center()
	global_position = _position
