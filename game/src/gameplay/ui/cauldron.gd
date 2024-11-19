class_name Cauldron extends Control

const MAX_INGREDIENTS: int = 4

@export var ingredient_container: Node

@onready var ingredients: Array[Node] = ingredient_container.get_children()
var active_ingredients_count = 0

func _ready() -> void:
    ingredients.map(func(x): x.hide())

func add_ingredient(ingredient_type: Ingredient.TYPES) -> void:
    if active_ingredients_count < MAX_INGREDIENTS:
        var current_ingredient: TextureRect = ingredients[active_ingredients_count] as TextureRect
        current_ingredient.show()

        var ingredient_name = Ingredient.INGREDIENT_NAMES[ingredient_type]
        current_ingredient.texture = load(Ingredient.INGREDIENT_ICON_FORMAT % ingredient_name)
        active_ingredients_count += 1
