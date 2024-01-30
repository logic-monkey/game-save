@tool
extends EditorPlugin

const NAME = "_SAVE"

func _enter_tree():
	add_autoload_singleton(NAME, "save.gd")

func _exit_tree():
	remove_autoload_singleton(NAME)
