extends Node2D

var character_scene = preload("res://objects/Character.tscn")
var characters = []
var hovered = false
var hover_offset = Vector2.ZERO

onready var area = $Area2D
onready var shape = area.get_node("CollisionShape2D").shape


func _ready():
    area.connect("mouse_entered", self, "_mouse_entered")
    area.connect("mouse_exited", self, "_mouse_exited")
    area.connect("input_event", self, "_input_event")


func _mouse_entered():
    self.hovered = true


func _mouse_exited():
    self.hovered = false


func _process(_delta):
    if self.hovered:
        if Input.is_mouse_button_pressed(BUTTON_LEFT):
            if self.hover_offset.length() == 0:
                self.hover_offset = global_position - get_global_mouse_position()
            global_position = get_global_mouse_position() + self.hover_offset
        elif Input.is_mouse_button_pressed(BUTTON_RIGHT):
            print("open edit")
        else:
            self.hover_offset = Vector2.ZERO


func set_word(word, scale=Vector2.ONE):
    # Remove unused to prevent memory leaks and resize
    if word.size() < characters.size():
        for index in range(characters.size()):
            if index >= word.size():
                characters[index].queue_free()
    self.characters.resize(word.size())

    for index in range(word.size()):
        var character = word[index]
        var lookup = Alphabet.get_character(character)
        if lookup["texture"] != null:
            var character_object = characters[index]
            if character_object == null:
                character_object = character_scene.instance()
                characters[index] = character_object
                add_child(character_object)

            character_object.set_character(
                lookup["angle"],
                lookup["texture"],
                index * TAU / 4,
                (index + 1) * 25,
                35,
                index + 1.5 * 30
            )
            shape.radius = (index + 1) * 25
        else:
            print("ERROR: ", character)

    self.scale = scale



func set_highlighted(value):
    for character in characters:
        character.color = Color.royalblue if value else Color.black
        print(value, " ", character.color)
        character.update()
