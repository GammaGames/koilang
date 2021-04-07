extends Node

export var debug = false

signal debug_changed


func _input(event):
    if event.is_action_pressed("ui_cancel"):
        self.debug = not self.debug
        emit_signal("debug_changed")
