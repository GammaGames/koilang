extends HBoxContainer

onready var add = $Add
onready var edit = $Edit
onready var move = $Move
onready var remove = $Remove

signal add
signal edit
signal move
signal remove


func _ready():
    add.connect("button_down", self, "_add_button_down")
    add.connect("toggled", self, "_add_toggled")
    edit.connect("button_down", self, "_edit_button_down")
    edit.connect("toggled", self, "_edit_toggled")
    move.connect("button_down", self, "_move_button_down")
    move.connect("toggled", self, "_move_toggled")
    remove.connect("button_down", self, "_remove_button_down")
    remove.connect("toggled", self, "_remove_toggled")

func _add_button_down():
    deselect_others(add)


func _add_toggled(value):
    if value:
        emit_signal("add")

func _edit_button_down():
    deselect_others(edit)


func _edit_toggled(value):
    if value:
        emit_signal("edit")

func _move_button_down():
    deselect_others(move)


func _move_toggled(value):
    if value:
        emit_signal("move")

func _remove_button_down():
    deselect_others(remove)


func _remove_toggled(value):
    if value:
        emit_signal("remove")



func deselect_others(button=null):
    for child in get_children():
        if child != button:
            child.pressed = false
