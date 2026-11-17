extends Node


@export var ren : int = 0
@export var p1x : int = 0
@export var p2x : int = 0
@export var ks : bool = false

@onready var _ip: LineEdit = $"../an/jm/jr/ip"
@onready var dk: LineEdit = $"../an/jm/jr/dk"

var wj : int = 0

var js : bool = false

@onready var _ren: Label = $"../_ren"
@onready var _1x: Label = $"../1x"
@onready var _2x: Label = $"../2x"


func _ready() -> void:
	pass


func create_fwd() -> Error :
	return Main.create_fwd()


func create_khd(ip :String, port : int) -> Error :
	return Main.create_khd(ip,port)



func _on_jr_pressed() -> void:
	create_khd(_ip.text,dk.text.to_int())
	await get_tree().create_timer(1).timeout
	zjr.rpc()
	wj = ren
	if (ren > 2) : 
		get_tree().get_multiplayer().multiplayer_peer.disconnect_peer(get_tree().get_multiplayer().get_unique_id())
		$"../an/jg".text = "房间满了"
		return
	$"../an/jm".visible = false


func _on_fh_pressed() -> void:
	$"../an/jm/cj".visible = true


func _on_fwd_pressed() -> void:
	create_fwd()
	zjr.rpc()
	wj = ren
	$"../an/jm".visible = false


func _on_khd_pressed() -> void:
	$"../an/jm/jr".visible = true


func _on_st_pressed() -> void:
	if(wj == 1) : p1xz.rpc(1)
	else : p2xz.rpc(1)
	$"../an/xd".visible = false

func _on_jd_pressed() -> void:
	if (wj == 1) : p1xz.rpc(2)
	else : p2xz.rpc(2)
	$"../an/xd".visible = false

func _on_b_pressed() -> void:
	if (wj == 1) : p1xz.rpc(3)
	else : p2xz.rpc(3)
	$"../an/xd".visible = false
	

func dj() -> int :
	
	if(p1x == 1 and p2x == 2) : return 1
	if(p1x == 1 and p2x == 3) : return 2
	if(p1x == 2 and p2x == 1) : return 2
	if(p1x == 2 and p2x == 3) : return 1
	if(p1x == 3 and p2x == 1) : return 1
	if(p1x == 3 and p2x == 2) : return 2
	return 0

func _physics_process(_delta: float) -> void:
	if (!js) :
		if(p1x and p2x ) :
#			await get_tree().create_timer(1).timeout
			if(dj() == wj):
				js = true
				$"../an/jg".text = "你赢了"
				$"../an/jg".visible = true
				await get_tree().create_timer(1).timeout
				$"../an/jg".visible = false
				$"../an/xd".visible = true
				p1xz.rpc(0)
				p2xz.rpc(0)
				$"../sl".chang += 1
				$"../sl".win += 1
				$"../sl".save_file()
			elif (dj() == 0):
				js = true
				$"../an/jg".text = "平手哦"
				$"../an/jg".visible = true
				await get_tree().create_timer(1).timeout
				$"../an/jg".visible = false
				$"../an/xd".visible = true
				p1xz.rpc(0)
				p2xz.rpc(0)
				$"../sl".save_file()
			else :
				js = true
				$"../an/jg".text = "你鼠了"
				$"../an/jg".visible = true
				await get_tree().create_timer(1).timeout
				$"../an/jg".visible = false
				$"../an/xd".visible = true
				$"../sl".chang += 1
				$"../sl".save_file()
	yxks()
	_ren.text =str(ren)
	_1x.text = str(p1x)
	_2x.text = str(p2x)
	if(js) :
		await get_tree().create_timer(0.5).timeout
		if(p1x == 0 and p2x == 0): js = false



@rpc("any_peer","call_local")
func zjr() -> void :
	ren += 1

@rpc("any_peer","call_local")
func p1xz(z : int ) :
	p1x = z

@rpc("any_peer","call_local")
func p2xz(z : int) :
	p2x = z


func yxks() -> void :
	if (ren < 2) : return
	if (wj > 2) : return
	if (ks) : return
	ks = true
	$"../an/xd".visible = true
