extends Node2D

var OFFSET = TAU / -4

export var arc = TAU / 2
export(Texture) var texture
export var radius = 60
export var width = 35
export var segments = 20


func set_character(arc, texture, angle=0, radius=50, width=35, segments=20):
    self.arc = arc
    self.texture = texture
    self.rotation = angle
    self.radius = radius
    self.width = width
    self.segments = segments
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
            PoolColorArray([
                Color.white,
                Color.red,
                Color.green,
                Color.blue
            ]),
            PoolVector2Array([
                Vector2(percent, 0),
                Vector2(percent + delta_percent, 0),
                Vector2(percent + delta_percent, 1),
                Vector2(percent, 1)
            ]),
            texture
        )

        current_segment += 1
