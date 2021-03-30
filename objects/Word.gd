extends Node2D

var character_scene = preload("res://objects/Character.tscn")
var characters = []


func set_word(word, scale=Vector2.ONE):
    # Remove unused to prevent memory leaks and resize
    if word.size() < characters.size():
        for index in range(characters.size()):
            if index >= word.size():
                characters[index].queue_free()
    self.characters.resize(word.size())

    for index in range(word.size()):
        var character = word[index]
        var lookup = Alphabet.get_character(character)
        if lookup["texture"] != null:
            var character_object = characters[index]
            if character_object == null:
                character_object = character_scene.instance()
                characters[index] = character_object
                add_child(character_object)

            character_object.set_character(
                lookup["angle"],
                lookup["texture"],
                index * TAU / 4,
                (index + 1) * 25,
                35,
                index + 1.5 * 30
            )

        else:
            print("ERROR: ", character)

    self.scale = scale



func set_highlighted(value):
    pass
