extends VBoxContainer

onready var rotation_slider = $Koi/VBoxContainer/Rotation/Slider
onready var scale_slider = $Koi/VBoxContainer/Scale/Slider
onready var tail_slider = $Koi/VBoxContainer/Tail/Slider
var word = null


func _ready():
    rotation_slider.connect("value_changed", self, "_rotation_changed")
    scale_slider.connect("value_changed", self, "_scale_changed")
    tail_slider.connect("value_changed", self, "_tail_changed")


func _rotation_changed(val):
    if self.word and self.word.koi:
        self.word.koi.rotation_degrees = val


func _scale_changed(val):
    if self.word and self.word.koi:
        self.word.koi.scale = Vector2.ONE * val


func _tail_changed(val):
    if self.word and self.word.koi:
        self.word.koi.angle = val
        self.word.koi.update()


func set_word(w):
    self.word = w
