extends Control

func _on_host_button_pressed():
	var port = _get_join_port()
	NetworkServer.host_game(port, 8)

func _on_join_button_pressed():
	var address = _get_join_address()
	var port = _get_join_port()
	NetworkServer.join_game(address, port)

func _get_join_address() -> String:
	var address_node = $VBoxContainer/HBoxContainer2/AddressLineEdit
	return address_node.text

func _get_join_port() -> int:
	var port_node = $VBoxContainer/HBoxContainer3/PortLineEdit
	var port_text = port_node.text
	return int(port_text)
