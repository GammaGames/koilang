tool
extends Resource
class_name MyDictionary

export(Array, String) var letters
export(Texture) var texture
export(Curve2D) var weight

func _init(l=[], t=null, w=null):
    self.letters = l
    self.texture = t
    self.weight = w


export(Array, Dictionary) var dict
