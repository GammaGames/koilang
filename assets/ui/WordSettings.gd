extends VBoxContainer

onready var scale_slider = $Word/VBoxContainer/ScaleSlider
onready var rotation_slider = $Word/VBoxContainer/RotationSlider
onready var characters_container = $Characters
onready var character_field = $Character
onready var koi_settings = $KoiSettings
var word
var characters = []
var editing_characters = []
var editing_characters_signal_ids = []


func _ready():
    rotation_slider.connect("value_changed", self, "_word_rotation_changed")
    scale_slider.connect("value_changed", self, "_word_scale_changed")


func _word_rotation_changed(val):
    if self.word:
        self.word.rotation_degrees = val


func _word_scale_changed(val):
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

    if self.word.has_koi:
        self.koi_settings.set_word(self.word)
        self.koi_settings.visible = true
    else:
        self.koi_settings.visible = false
    self.emit_signal("resized")


func edit_characters(char_indexes):
    for id in self.editing_characters_signal_ids:
        # TODO disconnect old signals
        pass

    # Get characters
    var prefix_chars = self.word.text.substr(0, char_indexes[0]).strip_edges().split(" ", false)
    var stop_at_char = self.word.text.substr(0, char_indexes[-1]).strip_edges().split(" ", false)
    for current in range(word.characters.size()):
        if current == stop_at_char.size():
            break
        if current >= prefix_chars.size():
            # TODO connect rotation and mirror sliders
            var char_rotation_slider = characters_container.get_child(current).get_node("RotationSlider")
            print(char_rotation_slider.value)
