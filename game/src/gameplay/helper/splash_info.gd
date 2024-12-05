class_name SplashInfo extends RefCounted

var type: Ingredient.TYPES
var start_position: Vector2

func _init(_type, _start_position):
    type = _type
    start_position = _start_position
