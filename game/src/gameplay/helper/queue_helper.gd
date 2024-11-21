class_name QueueHelper extends RefCounted

const QUEUE_SIZE = 3
const BAG_RANDOMIZER_COUNT = 2

var unqueued_ingredients: Array[Ingredient.TYPES] = []
var queued_ingredients: Array[Ingredient.TYPES] = []

var unqueued_potions: Array[Potion] = []
var queued_potions: Array[Potion] = []

func _init() -> void:
    refill_unqueued_ingredients()
    refill_unqueued_potions()
    for i in QUEUE_SIZE:
        queued_ingredients.append(unqueued_ingredients.pop_back())
        queued_potions.append(unqueued_potions.pop_back())

func refill_unqueued_ingredients():
    while unqueued_ingredients.size() <= (BAG_RANDOMIZER_COUNT - 1) * Ingredient.COUNT:
        unqueued_ingredients.append_array(Ingredient.TYPES.values())
        unqueued_ingredients.shuffle()

func cycle_ingredient_queue() -> Ingredient.TYPES:
    queued_ingredients.append(unqueued_ingredients.pop_back())
    refill_unqueued_ingredients()

    return queued_ingredients.pop_front()

func refill_unqueued_potions():
    while unqueued_potions.size() <= (BAG_RANDOMIZER_COUNT - 1) * Ingredient.COUNT:
        for type in Ingredient.TYPES.values():
            unqueued_potions.append(Potion.new(0, [type]))
        unqueued_potions.shuffle()

func get_front_potion():
    return queued_potions.front()

func cycle_potion_queue() -> Potion:
    queued_potions.append(unqueued_potions.pop_back())
    refill_unqueued_potions()

    return queued_potions.pop_front()
