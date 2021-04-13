extends Node

export(Array, Dictionary) var dict = []

var dictionary = [
    [["i", "u", "o", "oi"], [preload("res://assets/img/vowel_1.png")]],
    [["ii", "y", "e", "eu"], [preload("res://assets/img/vowel_2.png")]],
    [["ae", "ai", "au", "a"], [preload("res://assets/img/vowel_3.png")]],
    [["m", "n", "p", "b"], [
        preload("res://assets/img/consonant_1.png"),
        preload("res://assets/img/consonant_1_wide.png")
    ]],
    [["t", "d", "th", "ts"], [preload("res://assets/img/consonant_2.png")]],
    [["k", "kh", "g", "q"], [preload("res://assets/img/consonant_3.png")]],
    [["ph", "vh", "f", "v"], [preload("res://assets/img/consonant_4.png")]],
    [["s", "sh", "ch", "z"], [preload("res://assets/img/consonant_5.png")]],
    [["j", "c", "x", "h"], [preload("res://assets/img/consonant_6.png")]],
    [["'", "w", "l", "r"], [preload("res://assets/img/consonant_7.png")]],
]

func get_character(character):
    for index in range(dictionary.size()):
        if dictionary[index][0].has(character):
            var characters = dictionary[index][0]
            var char_index = characters.find(character)
            var textures = dictionary[index][1]
            return {
                "angle":  float(char_index + 1) / dictionary[index][0].size() * TAU,
                "texture": textures[floor(float(char_index) / characters.size() * textures.size())]
            }
    return {
        "angle":  -1,
        "texture": null
    }
