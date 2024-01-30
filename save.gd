extends Node

var data = {}
var _NAME = ProjectSettings["application/config/name"]
var _NUMBER = 0
var _FILE = "user://%s %s.sav" % [_NAME, _NUMBER]


func Save():

	var file = FileAccess.open_compressed(_FILE, FileAccess.WRITE)
	file.store_var(data)
	

signal loaded
var is_loaded := false

func Load():
	is_loaded = false
	if not FileAccess.file_exists(_FILE): 
		Save()
		is_loaded = true
		emit_signal("loaded")
		return
	var file = FileAccess.open_compressed(_FILE, FileAccess.READ)
	var sample_data = file.get_var()
	if sample_data is Dictionary: data = sample_data
	else : 
		is_loaded = true
		emit_signal("loaded")
		return
	is_loaded = true
	emit_signal("loaded")


func _ready():
	#await get_tree().process_frame
	#Load()
	#if not is_loaded: await loaded
	#Save()
	clear()
	
func clear():
	data = {}
	_NUMBER = -1

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if not is_loaded: await loaded
		Save()
