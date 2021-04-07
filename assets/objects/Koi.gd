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

    # fish go brrrrrrrrrrrrrrrrrr 😭 angles hard
    var current_segment = 0
    var current_angle = 0

    var delta_percent = 1.0 / segments

    # var delta_y = size / segments
    var delta_angle = delta_percent * angle
    print(delta_angle)

    # Draw top half
    var current_position = Vector2(0, -0.5 / segments * size)
    while current_segment < segments / 2:
        print("TOP")
        var percent = float(current_segment) / segments / 2
        draw_primitive(
            PoolVector2Array([
                current_position + Vector2(-0.5, 0) * size,
                current_position + Vector2(-0.5, 0.5 / segments) * size,
                current_position + Vector2(0.5, 0.5 / segments) * size,
                current_position + Vector2(0.5, 0) * size
            ]),
            PoolColorArray([Color.transparent, Color.blue, Color.transparent, Color.blue]),
            PoolVector2Array([
                Vector2(0, percent),
                Vector2(0, percent + delta_percent),
                Vector2(1, percent + delta_percent),
                Vector2(1, percent)
            ])
        )

        current_segment += 1
        current_angle += delta_angle
        current_position.y -= 0.5 / segments * size

    # Bottom half
    var previous_left = Vector2(-0.5, 0) * size
    var previous_right = Vector2(-0.5, 0) * size
    current_segment = 0
    current_position = Vector2.ZERO
    while current_segment < segments / 2:
        print("BOTTOM")
        var percent = float(current_segment) / segments
        var next_left = previous_left
        # next_left.y +=

        # draw_primitive(
        #     PoolVector2Array([
        #         current_position + Vector2(-0.5, 0) * size,
        #         current_position + Vector2(-0.5, 1.0 / segments) * size,
        #         current_position + Vector2(0.5, 1.0 / segments) * size,
        #         current_position + Vector2(0.5, 0) * size
        #     ]),
        #     PoolColorArray([Color.transparent, Color.blue, Color.transparent, Color.blue]),
        #     PoolVector2Array([
        #         Vector2(0, percent),
        #         Vector2(0, percent + delta_percent),
        #         Vector2(1, percent + delta_percent),
        #         Vector2(1, percent)
        #     ])
        # )
        draw_primitive(
            PoolVector2Array([
                current_position + Vector2(
                    -0.5 * cos(current_angle * percent),
                    0
                ) * size,
                current_position + Vector2(
                    -0.5 * cos(current_angle * percent),
                    1.0 / segments
                ) * size,
                current_position + Vector2(
                    0.5 * cos(current_angle * percent),
                    1.0 / segments
                ) * size,
                current_position + Vector2(
                    0.5 * cos(current_angle * percent),
                    0
                ) * size
            ]),
            PoolColorArray([Color.red, Color.blue, Color.transparent, Color.blue]),
            PoolVector2Array([
                Vector2(0, percent),
                Vector2(0, percent + delta_percent),
                Vector2(1, percent + delta_percent),
                Vector2(1, percent)
            ])
        )

        current_segment += 1
        current_angle += delta_angle
        current_position.y += 1.0 / segments * size
        current_position.x += cos(current_angle) / segments * size

    if segments % 2:
        print("extra")


func _rotation_changed(val):
    self.rotation_degrees = val
