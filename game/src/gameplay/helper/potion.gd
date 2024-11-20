class_name Potion extends RefCounted

var level: int
var types: Array[Ingredient.TYPES]

func _init(_level: int, _types: Array[Ingredient.TYPES]) -> void:
    level = _level
    types = _types
