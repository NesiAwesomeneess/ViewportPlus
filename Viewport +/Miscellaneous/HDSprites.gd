extends Node2D

func _ready():
	set_as_toplevel(true)

func _process(_delta):
	var hdsprites = get_tree().get_nodes_in_group("HD")
	
	for sprite in hdsprites:
		
		var node = sprite.get_parent()
		var package = PackedScene.new()
		var _error = package.pack(sprite)
		var _remote = RemoteTransform2D.new()
		
		var hdsprite = package.instance()
		var hdparent = Node2D.new()
		
		_remote.use_global_coordinates = true
		
		hdparent.add_child(hdsprite)
		add_child(hdparent)
		node.add_child(_remote)
		
		_remote.remote_path = _remote.get_path_to(hdparent)
		
		if sprite is Node2D:
			_remote.position = sprite.position
			hdsprite.position = Vector2()
		
		for signals in sprite.get_signal_list():
			var signal_name = signals["name"]
			for connection in sprite.get_signal_connection_list(signal_name):
				hdsprite.connect(connection["signal"], connection["target"], connection["method"])
		
		for signals in sprite.get_incoming_connections():
			if !signals["source"].is_connected(signals["signal_name"], hdsprite, signals["method_name"]):
				signals["source"].connect(signals["signal_name"], hdsprite, signals["method_name"])
		
		hdsprite.remove_from_group("HD")
		_error = _remote.connect("tree_exited", hdparent, "queue_free")
		
		sprite.queue_free()
