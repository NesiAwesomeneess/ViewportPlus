extends Camera2D

#

func _process(_delta):
	var elements = get_tree().get_nodes_in_group("Parallax")
	var camera_position : Vector2 = get_camera_screen_center()
	
	for element in elements:
		var element_origin = element.get_parent().global_position + element.center_offset
		element.position = ((camera_position - element_origin)*element.motion).floor()
