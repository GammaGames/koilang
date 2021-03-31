extends Node2D

onready var words_parent = $Words
onready var editor_window = $CanvasLayer/WindowDialog
onready var stack = editor_window.get_node("MarginContainer/Stack")
onready var editor = stack.get_node("TextEdit")
# onready var word_container = editor_window.get_node("Word")

var word_scene = preload("res://objects/Word.tscn")
var word_edit_scene = preload("res://objects/WordEdit.tscn")
var word_edit_node = null
var words = []
var dragging = null


func _ready():
    editor_window.popup()
    editor_window.get_close_button().visible = false
    editor_window.connect("popup_hide", self, "_popup_hide")
    editor.connect("text_changed", self, "_text_changed")
    editor.connect("cursor_changed", self, "_cursor_changed")
    editor.grab_focus()


func _popup_hide():
    editor_window.popup()


func _text_changed():
    # var current_line = editor.cursor_get_line()
    var lines = filter_array(editor.text.to_lower().split("\n"))

    # Remove unused to prevent memory leaks and resize
    if lines.size() < words.size():
        for index in range(words.size()):
            if index >= lines.size():
                words[index].queue_free()
    self.words.resize(lines.size())

    for index in range(lines.size()):
        var word = lines[index].split(" ")
        var word_object = words[index]
        if word_object == null:
            word_object = word_scene.instance()
            words[index] = word_object
            words_parent.add_child(word_object)

        word_object.set_word(word)



func _cursor_changed():
    var current_line = editor.cursor_get_line()
    if self.word_edit_node:
        self.word_edit_node.queue_free()

    for index in range(words.size()):
        if words[index]:
            words[index].set_highlighted(index == current_line)
            if index == current_line:
                self.word_edit_node = word_edit_scene.instance()
                self.stack.add_child(self.word_edit_node)
                self.word_edit_node.set_word(words[index])

                self.word_edit_node.visible = words[index].text.length()


func filter_array(arr):
    var results = []
    for row in arr:
        results.append(row.strip_edges())

    return results


func _input(event):
    if event is InputEventMouseButton:
        if event.pressed and event.button_index == BUTTON_LEFT:
            self.dragging = get_hovering()
            if self.dragging:
                self.dragging.start_dragging()
        # elif not event.pressed and event.button_index == BUTTON_RIGHT:
        #     var word_dialog = word_dialog_scene.instance()
        #     word_dialog.set_word(target)
        #     add_child(word_dialog)
        #     print("EDIT")

        elif self.dragging:
            self.dragging.stop_dragging()
            self.dragging = null


func get_hovering():
    for word in words:
        if word.hovering:
            return word
