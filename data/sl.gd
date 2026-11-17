extends Label

var win : float = 0
var chang : float = 0
@onready var _sl: Label = $"."

@onready var _win: Label = $"../_win"
@onready var _chang: Label = $"../_chang"



func _ready() -> void:
	load_file()
	pass



func _process(_delta: float) -> void:
	if chang ==0 : _sl.text = str(0,"%") 
	else :_sl.text = str(snapped(win/chang,0.1)*100.0,"%")
	
	_win.text = str(win)
	_chang.text = str(chang)
	
	#if(Input.is_key_pressed(KEY_P)):
		#$"../1x".visible = true
		#$"../2x".visible = true
	#else :
		#$"../1x".visible = false
		#$"../2x".visible = false


func load_file():
	var config : ConfigFile = ConfigFile.new()
	
	var err : Error = config.load("user://sl.cfg")
	if err != Error.OK :
		var _config : ConfigFile = ConfigFile.new()
		
		config.set_value("sl","chang",0)
		config.set_value("sl","win",0)
		
		config.save("user://sl.cfg")
		return
	
	for sl in config.get_sections():
		win = config.get_value(sl,"win")
		chang = config.get_value(sl,"chang")

func save_file():
	var config : ConfigFile = ConfigFile.new()
	
	config.set_value("sl","chang",chang)
	config.set_value("sl","win",win)
	
	config.save("user://sl.cfg")
	
	
	
	
