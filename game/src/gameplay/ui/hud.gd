class_name Hud extends Control

@onready var ingredient_queue: IngredientQueue = $IngredientQueue
@onready var potion_queue: PotionQueue = $PotionQueue
@onready var score_container: ScoreContainer = $ScoreContainer

func update_ingredient_queue(ingredient_types: Array[Ingredient.TYPES]):
    ingredient_queue.set_queue_icon_textures(ingredient_types)

func update_potion_queue(potions: Array[Potion]):
    potion_queue.set_queue_icon_textures(potions)

func update_score(new_score: int):
    score_container.update_score(new_score)
