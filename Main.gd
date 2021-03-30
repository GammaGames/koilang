extends Node2D

onready var editor_window = $CanvasLayer/WindowDialog
onready var editor = editor_window.get_node("MarginContainer/TextEdit")

var word_scene = preload("res://objects/Word.tscn")
var words = []


func _ready():
    editor_window.popup()
    editor_window.get_close_button().visible = false
    editor_window.connect("popup_hide", self, "_popup_hide")
    editor.connect("text_changed", self, "_text_changed")
    _text_changed()


func _popup_hide():
    editor_window.popup()


func _text_changed():
    var current_line = editor.cursor_get_line() - 1
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
            $Words.add_child(word_object)

        word_object.set_word(word)
        word_object.set_highlighted(index == current_line)


func filter_array(arr):
    var results = []
    for row in arr:
        var result = row.strip_edges()
        if result.length():
            results.append(result)

    return results
