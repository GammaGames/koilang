extends Node

var tuples = [
    [["i", "u", "o", "oi"], preload("res://images/vowel_1.png")],
    [["ii", "y", "e", "eu"], preload("res://images/vowel_2.png")],
    [["ae", "ai", "au", "a"], preload("res://images/vowel_3.png")],

    [["m", "n", "p", "b"], preload("res://images/consonant_1.png")],
    [["t", "d", "th", "ts"], preload("res://images/consonant_2.png")],
    [["k", "kh", "g", "q"], preload("res://images/consonant_3.png")],
    [["ph", "vh", "f", "v"], preload("res://images/consonant_4.png")],
    [["s", "sh", "ch", "z"], preload("res://images/consonant_5.png")],
    [["j", "c", "x", "h"], preload("res://images/consonant_6.png")],
    [["'", "w", "l", "r"], preload("res://images/consonant_7.png")],
]

func get_character(character):
    for index in range(tuples.size()):
        var search_index = tuples[index][0].find(character)
        if search_index > -1:
            return {
                "angle":  float(search_index + 1) * TAU / tuples[index][0].size(),
                "texture": tuples[index][1]
            }
    return {
        "angle":  -1,
        "texture": null
    }
