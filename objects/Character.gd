extends Node2D

var OFFSET = TAU / -4

export var arc = TAU / 2
export(Texture) var texture
export var radius = 60
export var width = 35
export var segments = 20
export var color = Color.black


func set_character(ar, tex, ang=0, rad=50, w=35, segs=20):
    self.arc = ar
    self.texture = tex
    self.rotation = ang
    self.radius = rad
    self.width = w
    self.segments = segs
    update()


func _draw():
    var current_segment = 0
    var delta_percent = 1.0 / segments
    var delta_arc = delta_percent * arc
    while current_segment < segments:
        var percent = float(current_segment) / segments
        var current_arc = arc * percent + OFFSET

        draw_primitive(
            PoolVector2Array([
                Vector2(cos(current_arc), sin(current_arc)) * (radius + width / 2),
                Vector2(cos(current_arc + delta_arc), sin(current_arc + delta_arc)) * (radius + width / 2),
                Vector2(cos(current_arc + delta_arc), sin(current_arc + delta_arc)) * (radius - width / 2),
                Vector2(cos(current_arc), sin(current_arc)) * (radius - width / 2)
            ]),
            PoolColorArray([color, color, color, color]),
            PoolVector2Array([
                Vector2(percent, 0),
                Vector2(percent + delta_percent, 0),
                Vector2(percent + delta_percent, 1),
                Vector2(percent, 1)
            ]),
            texture
        )
        current_segment += 1
