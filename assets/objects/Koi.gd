extends Node2D


var OFFSET = TAU / 4
var texture = preload("res://assets/img/koi.png")

export var angle = 0
# export var arc = TAU
# export var radius = 60
# export var width = 35
var segments = 8
export var offset = Vector2.ZERO
# export var color = Color.black
var size = 400


# func _process(delta):
#     self.angle += TAU / 20 * delta
#     if self.angle > 0.35:
#         self.angle = -0.35
#     update()


func set_angle(ang):
    self.angle = ang
    update()


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
    draw_primitive(
        PoolVector2Array([
            Vector2(-0.5 + cos(angle / 2 + OFFSET), -0.35) * size,
            Vector2(-0.5, 0) * size,
            Vector2(0.5, 0) * size,
            Vector2(0.5 + cos(angle / 2 + OFFSET), -0.35) * size
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
    draw_primitive(
        PoolVector2Array([
            Vector2(-0.5, 0) * size,
            Vector2(-0.5 + cos(angle + OFFSET), 0.65) * size,
            Vector2(0.5 + cos(angle + OFFSET), 0.65) * size,
            Vector2(0.5, 0) * size
        ]),
        PoolColorArray([Color.white, Color.white, Color.white, Color.white]),
        PoolVector2Array([
            Vector2(0, 0.35),
            Vector2(0, 1.0),
            Vector2(1, 1.0),
            Vector2(1, 0.35)
        ]),
        texture
    )
    return


func _rotation_changed(val):
    self.rotation_degrees = val
