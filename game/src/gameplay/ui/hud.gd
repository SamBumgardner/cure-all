class_name Hud extends Control

@onready var ingredient_queue: IngredientQueue = $IngredientQueue
@onready var potion_queue: PotionQueue = $PotionQueue

func update_ingredient_queue(ingredient_types: Array[Ingredient.TYPES]):
    ingredient_queue.set_queue_icon_textures(ingredient_types)

func update_potion_queue(potions: Array[Potion]):
    potion_queue.set_queue_icon_textures(potions)
