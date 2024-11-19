class_name Hud extends Control

@onready var ingredient_queue: IngredientQueue = $IngredientQueue

func update_ingredient_queue(ingredient_types: Array[Ingredient.TYPES]):
    ingredient_queue.set_queue_icon_textures(ingredient_types)
