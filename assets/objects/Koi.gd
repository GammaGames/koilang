extends Node2D


var OFFSET = TAU / -4
var texture = preload("res://assets/img/koi.png")

export var angle = TAU / 8
# export var arc = TAU
# export var radius = 60
# export var width = 35
export var segments = 10
export var offset = Vector2.ZERO
# export var color = Color.black


func set_fish(ang=0, rot=0):
    self.angle = ang
    self.rotation = rot
    # self.arc = ar
    # self.texture = tex
    # self.rotation = ang
    # self.radius = rad
    # self.width = w
    # self.segments = segs
    update()


func _draw():
    # Draw the base body
    draw_primitive(
        PoolVector2Array([
            Vector2(-0.5, -0.35) * 200,
            Vector2(-0.5, 0) * 200,
            Vector2(0.5, 0) * 200,
            Vector2(0.5, -0.35) * 200
        ]),
        PoolColorArray([Color.white, Color.white, Color.white, Color.white]),
        PoolVector2Array([
            Vector2(0, 0),
            Vector2(0, 0.35),
            Vector2(1, 0.35),
            Vector2(1, 0)
        ]),
        texture
    )

    var current_segment = 0
    var current_position = Vector2.ZERO
    var delta_percent = 1.0 / segments
    var delta_angle = delta_percent * angle
    while current_segment < segments:
        var percent = float(current_segment) / segments
        current_position.x -= cos(delta_angle) * 10
        current_position.y += sin(delta_angle) * 100
        print(percent, " ", current_position)

        # var current_arc = angle * percent + OFFSET

        draw_primitive(
            PoolVector2Array([
                current_position + Vector2(-0.5, -0.1) * 200,
                current_position + Vector2(-0.5, 0.1) * 200,
                current_position + Vector2(0.5, 0.1) * 200,
                current_position + Vector2(0.5, -0.1) * 200
            ]),
            PoolColorArray([Color.white, Color.red, Color.green, Color.blue]),
            PoolVector2Array([
                Vector2(percent, 0),
                Vector2(percent + delta_percent, 0),
                Vector2(percent + delta_percent, 1),
                Vector2(percent, 1)
            ]),
            texture
        )
        # draw_primitive(
        #     PoolVector2Array([
        #         Vector2(cos(current_arc), sin(current_arc)) * (radius + width / 2),
        #         Vector2(cos(current_arc + delta_arc), sin(current_arc + delta_arc)) * (radius + width / 2),
        #         Vector2(cos(current_arc + delta_arc), sin(current_arc + delta_arc)) * (radius - width / 2),
        #         Vector2(cos(current_arc), sin(current_arc)) * (radius - width / 2)
        #     ]),
        #     PoolColorArray([color, color, color, color]),
        #     PoolVector2Array([
        #         Vector2(percent, 0),
        #         Vector2(percent + delta_percent, 0),
        #         Vector2(percent + delta_percent, 1),
        #         Vector2(percent, 1)
        #     ]),
        #     texture
        # )
        current_segment += 1


func _rotation_changed(val):
    self.rotation_degrees = val
