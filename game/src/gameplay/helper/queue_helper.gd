class_name QueueHelper extends RefCounted

const QUEUE_SIZE = 3
const BAG_RANDOMIZER_COUNT = 2

var unqueued_ingredients: Array[Ingredient.TYPES] = []
var queued_ingredients: Array[Ingredient.TYPES] = []
var queued_ingredient_names: Array:
    get():
        return queued_ingredients.map(func(x): return Ingredient.INGREDIENT_NAMES[x])

func _init() -> void:
    refill_unqueued_ingredients()
    for i in QUEUE_SIZE:
        queued_ingredients.append(unqueued_ingredients.pop_back())

func refill_unqueued_ingredients():
    while unqueued_ingredients.size() <= (BAG_RANDOMIZER_COUNT - 1) * Ingredient.COUNT:
        unqueued_ingredients.append_array(Ingredient.TYPES.values())
        unqueued_ingredients.shuffle()

func cycle_queue() -> Ingredient.TYPES:
    queued_ingredients.append(unqueued_ingredients.pop_back())
    refill_unqueued_ingredients()

    return queued_ingredients.pop_front()
