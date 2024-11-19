class_name Ingredient extends RefCounted

const NONE: int = -1
const DIAMOND: int = 0
const MOON: int = 1
const SQUARE: int = 2
const STAR: int = 3
const TRIANGLE: int = 4
const COUNT: int = 5

enum TYPES {
    DIAMOND = 0,
    MOON = 1,
    SQUARE = 2,
    STAR = 3,
    TRIANGLE = 4
}

const INGREDIENT_NAMES: Array[String] = [
    "diamond",
    "moon",
    "square",
    "star",
    "triangle",
]
const INGREDIENT_ICON_FORMAT: String = "res://assets/art/%s_icon.png"
