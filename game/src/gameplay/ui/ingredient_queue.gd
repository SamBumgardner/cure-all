class_name IngredientQueue extends HBoxContainer

@onready var queue_icons: Array[TextureRect] = [
    $FirstIngredient/VBoxContainer/Icon,
    $SecondIngredient/Icon,
    $ThirdIngredient/Icon
]

func set_queue_icon_textures(ingredients: Array[Ingredient.TYPES]):
    for i in queue_icons.size():
        queue_icons[i].texture = load(Ingredient.INGREDIENT_ICON_FORMAT % Ingredient.INGREDIENT_NAMES[ingredients[i]])
