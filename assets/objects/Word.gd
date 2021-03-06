extends Node2D

var text = ""
var word = []
var koi_scene = preload("res://assets/objects/Koi.tscn")
var character_scene = preload("res://assets/objects/Character.tscn")
var characters = []
var has_koi = false
var koi = null
var hovering = false
var dragging = false
var mouse_offset = Vector2.ZERO


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



func set_word(w, t=""):
    self.text = t
    self.word = w
    # Remove unused to prevent memory leaks and resize
    if word.size() < characters.size():
        for index in range(characters.size()):
            if index >= self.word.size():
                characters[index].queue_free()
    self.characters.resize(self.word.size())

    for index in range(self.word.size()):
        var character = self.word[index]
        if character:
            var lookup = Alphabet.get_character(character)
            if lookup["texture"] != null:
                var character_object = characters[index]
                if character_object == null:
                    character_object = character_scene.instance()
                    characters[index] = character_object
                    add_child(character_object)
                    character_object.rotation = fmod(index * TAU / 5, TAU)

                var radius = (index + 1) * 30
                var width = 40
                var segments = rad2deg(lookup["angle"]) / 4
                character_object.set_character(
                    lookup["angle"],
                    lookup["texture"],
                    radius,
                    width,
                    segments
                )
            else:
                print("ERROR: ", character)


func set_highlighted(value):
    for character in self.characters:
        if character:
            character.color = Color.royalblue if value else Color.black
            character.update()


func set_koi(value):
    self.has_koi = value

    if self.has_koi and not self.koi:
        self.koi = koi_scene.instance()
        add_child(self.koi)
    elif self.koi:
        self.koi.queue_free()
        self.koi = null


func update():
    for ch in characters:
        ch.update()
