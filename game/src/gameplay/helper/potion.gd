class_name Potion extends RefCounted

const POTION_ICON_FORMAT: String = "res://assets/art/%s_potion.png"

var level: int
var types: Array[Ingredient.TYPES]

func _init(_level: int, _types: Array[Ingredient.TYPES]) -> void:
    level = _level
    types = _types
