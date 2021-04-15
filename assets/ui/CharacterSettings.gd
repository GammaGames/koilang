extends HBoxContainer

onready var slider = $RotationSlider
var character = null
var linked_characters = []
var previous_value = 0



func link_characters(characters):
    self.unlink_characters()
    for character in characters:
        if character != self:
            slider.share(character.slider)

    self.linked_characters = characters


func unlink_characters():
    slider.unshare()
