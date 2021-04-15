extends VBoxContainer

onready var scale_slider = $Word/VBoxContainer/ScaleSlider
onready var rotation_slider = $Word/VBoxContainer/RotationSlider
onready var characters_container = $Characters
onready var character_field = $Character
onready var koi_settings = $KoiSettings
var word
var characters = []


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
    self.rotation_slider.value = self.word.rotation_degrees

    if self.characters_container.get_children().size() >  self.word.word.size():
        for index in range(self.characters_container.get_children().size()):
            if index >= self.word.characters.size():
                self.characters_container.get_child(index).queue_free()

    for index in range(self.word.word.size()):
        var ch = self.word.word[index]
        var character = self.word.characters[index]

        if ch:
            var field = self.characters_container.get_child(index)
            if field == null:
                field = character_field.duplicate()
                field.visible = true
                characters_container.add_child(field)

            if field.character != character:
                field.get_node("RotationSlider").disconnect("value_changed", field.character, "_rotation_changed")
                field.get_node("MirrorToggle").disconnect("toggled", field.character, "_mirror_changed")
                field.get_node("RotationSlider").connect("value_changed", character, "_rotation_changed")
                field.get_node("MirrorToggle").connect("toggled", character, "_mirror_changed")

            field.get_node("Label").text = ch
            field.get_node("RotationSlider").value = character.rotation_degrees
            field.get_node("MirrorToggle").pressed = character.mirrored
            field.character = character
            # self.characters.append(field)

    if self.word.has_koi:
        self.koi_settings.set_word(self.word)
        self.koi_settings.visible = true
    else:
        self.koi_settings.visible = false
    self.emit_signal("resized")


func edit_characters(char_indexes):
    for node in characters_container.get_children():
        node.unlink_characters()
    # for id in self.editing_characters_signal_ids:

        # TODO disconnect old signals
        # pass

    # Get characters
    var prefix_chars = self.word.text.substr(0, char_indexes[0]).strip_edges().split(" ", false)
    var stop_at_char = self.word.text.substr(0, char_indexes[-1]).strip_edges().split(" ", false)
    var linked_characters = []
    for current in range(word.characters.size()):
        if current == stop_at_char.size():
            break
        if current >= prefix_chars.size():
            linked_characters.append(characters_container.get_child(current))

    for character in linked_characters:
        character.link_characters(linked_characters)
