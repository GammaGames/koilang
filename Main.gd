extends Node2D

onready var camera = $Camera2D
onready var words_parent = $Words
onready var editor_window = $CanvasLayer/WindowDialog
onready var stack = editor_window.get_node("MarginContainer/Stack")
onready var editor = stack.get_node("TextEdit")
onready var word_settings = stack.get_node("WordSettings")

var word_scene = preload("res://assets/objects/Word.tscn")
var word_edit_node = null
var words = []
var selected_word = null
var selected_words = []
# var dragging = null


func _ready():
    Settings.connect("debug_changed", self, "_debug_changed")
    editor_window.popup()
    editor_window.get_close_button().visible = false
    editor_window.connect("popup_hide", self, "_popup_hide")
    editor.connect("text_changed", self, "_text_changed")
    editor.connect("cursor_changed", self, "_cursor_changed")
    editor.connect("breakpoint_toggled", self, "_breakpoint_toggled")
    editor.grab_focus()


func _popup_hide():
    editor_window.popup()


func _debug_changed():
    for word in words:
        word.update()


func _text_changed():
    # var current_line = editor.cursor_get_line()
    var lines = filter_array(editor.text.to_lower().split("\n"))
    # var breakpoints = editor.get_breakpoints()

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

        word_object.set_word(word, lines[index])


func _cursor_changed():
    self.selected_words = []
    var current_lines = [editor.cursor_get_line()] if !editor.get_selection_text() \
        else range(editor.get_selection_from_line(), editor.get_selection_to_line() + 1)
    var current_chars = -1 if current_lines.size() > 1 \
        else range(editor.get_selection_from_column(), editor.get_selection_to_column() + 1)

    for index in range(words.size()):
        if words[index]:
            if current_lines.has(index):
                words[index].set_highlighted(true)
                self.word_settings.set_word(words[index])
                self.word_settings.visible = words[index].text.length()
                self.selected_words.append(words[index])

                if current_lines.size() == 1:
                    self.word_settings.edit_characters(current_chars)
            else:
                words[index].set_highlighted(false)

    if self.selected_words.size() > 1:
        word_settings.visible = false

    # if self.selected_words.size() == 1:
    #     self.selected_words = []
    # else:
    #     print("Lines: ", editor.get_selection_from_line(), " -> ", editor.get_selection_to_line())
    #     print("Columns: ", , " -> ", )


func _breakpoint_toggled(row):
    var breakpoints = editor.get_breakpoints()
    for index in range(words.size()):
        var word = words[index]
        if word.has_koi != breakpoints.has(index):
            word.set_koi(breakpoints.has(index))
            self.word_settings.set_word(word)


func filter_array(arr):
    var results = []
    for row in arr:
        results.append(row.strip_edges())

    return results


func _input(event):
    if event is InputEventMouseButton:
        if event.pressed and event.button_index == BUTTON_LEFT:
            var window_rect = editor_window.get_rect()
            # Offset the position by a bit because it doesn't include title bar
            window_rect.position.y -= 30
            window_rect.end.y += 30
            if !window_rect.has_point(event.position):
                for word in self.selected_words:
                    word.start_dragging()

        else:
            for word in self.selected_words:
                word.stop_dragging()


func get_hovering():
    for word in words:
        if word.hovering:
            return word
