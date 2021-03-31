extends Node2D

var text = ""
var word = []
var character_scene = preload("res://objects/Character.tscn")
var characters = []
var hovering = false
var dragging = false
var mouse_offset = Vector2.ZERO

onready var area = $Area2D
onready var shape = area.get_node("CollisionShape2D").shape


func _ready():
    area.connect("mouse_entered", self, "_mouse_entered")
    area.connect("mouse_exited", self, "_mouse_exited")


func _mouse_entered():
    self.hovering = true


func _mouse_exited():
    self.hovering = false


func start_dragging():
    self.mouse_offset = global_position - get_global_mouse_position()
    self.dragging = true


func stop_dragging():
    self.dragging = false


func _input(event):
    if event is InputEventMouseMotion and self.dragging:
        global_position = get_global_mouse_position() + self.mouse_offset



func set_word(w):
    self.text = w.join("").strip_edges()
    self.word = w
    # Remove unused to prevent memory leaks and resize
    if word.size() < characters.size():
        for index in range(characters.size()):
            if index >= self.word.size():
                characters[index].queue_free()
    self.characters.resize(self.word.size())

    for index in range(self.word.size()):
        var character = self.word[index]
        var lookup = Alphabet.get_character(character)
        if lookup["texture"] != null:
            var character_object = characters[index]
            if character_object == null:
                character_object = character_scene.instance()
                characters[index] = character_object
                add_child(character_object)

            var radius = (index + 1) * 35
            var width = 35
            var segments = index + 1.5 * 30
            character_object.set_character(
                lookup["angle"],
                lookup["texture"],
                index * TAU / 5,
                radius,
                width,
                segments
            )
            shape.radius = radius
        else:
            print("ERROR: ", character)


func set_highlighted(value):
    for character in self.characters:
        if character:
            character.color = Color.royalblue if value else Color.black
            character.update()
