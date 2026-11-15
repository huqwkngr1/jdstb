extends Node

var _peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()


func create_fwd() -> Error:
	var port : int =11451
	while(port <= 65535) :
		var err : Error = _peer.create_server(port)
		if (err == Error.OK): break
		port +=1
	if (port > 65535) : return Error.FAILED
	
	get_tree().get_multiplayer().multiplayer_peer = _peer
	return Error.OK

func create_khd(ip : String,port :int) -> Error :
	var err :Error = _peer.create_client(ip,port)
	if (err == Error.OK):
		get_tree().get_multiplayer().multiplayer_peer =_peer
	return err
