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

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("ui_accept"):
        if active_ingredients_count < MAX_INGREDIENTS:
            var new_ingredient_type = INGREDIENT_TYPES.pick_random()
            add_ingredient(new_ingredient_type)

func add_ingredient(ingredient_type: String) -> void:
    var current_ingredient: TextureRect = ingredients[active_ingredients_count] as TextureRect
    current_ingredient.show()
    current_ingredient.texture = load(INGREDIENT_ICON_FORMAT % ingredient_type)
    active_ingredients_count += 1
