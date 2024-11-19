class_name Cauldron extends Control

const MAX_INGREDIENTS: int = 4
const INGREDIENT_TYPES: Array[String] = [
    "diamond",
    "moon",
    "square",
    "star",
    "triangle",
]
const INGREDIENT_ICON_FORMAT: String = "res://assets/art/%s_icon.png"

@export var ingredient_container: Node

@onready var ingredients: Array[Node] = ingredient_container.get_children()
var active_ingredients_count = 0

func _ready() -> void:
    ingredients.map(func(x): x.hide())

func add_ingredient(ingredient_type: String) -> void:
    if active_ingredients_count < MAX_INGREDIENTS:
        var current_ingredient: TextureRect = ingredients[active_ingredients_count] as TextureRect
        current_ingredient.show()
        current_ingredient.texture = load(INGREDIENT_ICON_FORMAT % ingredient_type)
        active_ingredients_count += 1
