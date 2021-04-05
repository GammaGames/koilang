extends VBoxContainer

onready var scale_slider = $Word/ScaleSlider
onready var scale_input = $Word/ScaleInput
onready var characters_container = $Characters
onready var character_field = $Character
var word
var characters = []


func _ready():
    scale_slider.connect("value_changed", self, "_word_slider_changed")
    scale_input.connect("value_changed", self, "_word_scale_changed")


func _word_slider_changed(val):
    self.scale_input.value = val


func _word_scale_changed(val):
    self.scale_slider.value = val

    if self.word:
        self.word.scale = Vector2.ONE * val


func set_word(w):
    self.word = w
    self.scale_slider.value = self.word.scale.x

    for child in characters_container.get_children():
        child.queue_free()
    self.characters = []

    for index in range(word.word.size()):
        var ch = word.word[index]
        var character = word.characters[index]

        if ch:
            var field = character_field.duplicate()
            field.get_node("Label").text = ch
            field.get_node("RotationSlider").value = character.rotation_degrees
            field.get_node("RotationSlider").connect("value_changed", character, "_rotation_changed")
            field.get_node("MirrorToggle").pressed = character.mirrored
            field.get_node("MirrorToggle").connect("toggled", character, "_mirror_changed")
            field.visible = true
            characters_container.add_child(field)
            self.characters.append(field)
