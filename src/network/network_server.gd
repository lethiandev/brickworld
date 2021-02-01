extends Node

var peer: NetworkedMultiplayerPeer = null

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_peer_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_peer_disconnected")
	get_tree().connect("connected_to_server", self, "_on_connection_success")
	get_tree().connect("connection_failed", self, "_on_connection_failure")
	get_tree().connect("server_disconnected", self, "_on_server_disconnected")

func host_game(p_port: int, p_maxclients: int) -> void:
	peer = _create_network_peer()
	if peer.create_server(p_port, p_maxclients) == OK:
		print("Server peer created")
		get_tree().set_network_peer(peer)
	else:
		printerr("Failed to create server peer")

func join_game(p_address: String, p_port: int) -> void:
	peer = _create_network_peer()
	if peer.create_client(p_address, p_port) == OK:
		print("Client peer created")
		get_tree().set_network_peer(peer)
	else:
		printerr("Failed to create client peer")

func _create_network_peer() -> NetworkedMultiplayerPeer:
	peer = NetworkedMultiplayerENet.new()
	return peer

func _on_connection_success() -> void:
	print("Connected to the server")

func _on_connection_failure() -> void:
	printerr("Failed to connect to the server")

func _on_server_disconnected() -> void:
	print("Server disconnected")

func _on_peer_connected(p_id: int) -> void:
	print("Peer %d connected" % p_id)
	var player_name = "Player_%d" % p_id
	var player_node = Node.new()
	player_node.set_network_master(p_id)
	player_node.name = player_name
	add_child(player_node)

func _on_peer_disconnected(p_id: int) -> void:
	print("Peer %d disconnected" % p_id)
	var player_name = "Player_%d" % p_id
	var player_node = get_node(player_name)
	player_node.queue_free()
