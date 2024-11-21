class_name Cauldron extends Control

signal potion_produced(
    potion: Potion,
    splash_left: Array[Ingredient.TYPES],
    splash_right: Array[Ingredient.TYPES]
)

const MAX_INGREDIENTS: int = 4
const MIN_MATCH: int = 2
const EMPTY_CAULDRON: Array[int] = [-1, -1, -1, -1]

@export var ingredient_container: Node

@onready var ingredient_displays: Array[Node] = ingredient_container.get_children()
var ingredient_types: Array[int] = EMPTY_CAULDRON.duplicate()
var held_count: int:
    get():
        return ingredient_types.filter(func(x): return x != -1).size()

func _ready() -> void:
    ingredient_displays.map(func(x): x.modulate = Color.TRANSPARENT)

func add_ingredient(ingredient_type: Ingredient.TYPES, is_left_side: bool = true) -> void:
    if held_count < MAX_INGREDIENTS:
        var ingredient_index = get_next_available_ingredient_slot(is_left_side)
        ingredient_types[ingredient_index] = ingredient_type

        var current_ingredient: TextureRect = ingredient_displays[ingredient_index] as TextureRect
        current_ingredient.modulate = Color.WHITE
        var ingredient_name = Ingredient.INGREDIENT_NAMES[ingredient_type]
        current_ingredient.texture = load(Ingredient.INGREDIENT_ICON_FORMAT % ingredient_name)

        if held_count == MAX_INGREDIENTS:
            full_brew()

func get_next_available_ingredient_slot(left_side: bool) -> int:
    var end_offset: int = -2 if left_side else -1
    for i in range(ingredient_types.size() + end_offset, -1, -2):
        if ingredient_types[i] == -1:
            return i
    
    end_offset = -2 if not left_side else -1
    for i in range(ingredient_types.size() + end_offset, -1, -2):
        if ingredient_types[i] == -1:
            return i
    
    # should never reach here, error scenario
    return -1

func full_brew() -> void:
    var ingredient_counts: Array[Array] = []
    for i in Ingredient.TYPES.size():
        ingredient_counts.push_back([])
    
    var potion: Potion = Potion.new(-1, [])
    for i in held_count:
        ingredient_counts[ingredient_types[i]].push_back(i)

        var matching_ingredient_count = ingredient_counts[ingredient_types[i]].size()
        potion.level = max(matching_ingredient_count - MIN_MATCH, potion.level)

        if matching_ingredient_count == MIN_MATCH:
            potion.types.push_back(ingredient_types[i])
    
    var splash_left: Array[Ingredient.TYPES] = []
    var splash_right: Array[Ingredient.TYPES] = []
    for i in ingredient_counts.size():
        if ingredient_counts[i].size() < MIN_MATCH:
            for index in ingredient_counts[i]:
                if index % 2 == 0:
                    splash_left.push_back(i)
                else:
                    splash_right.push_back(i)
        
    empty_cauldron()
    potion_produced.emit(potion, splash_left, splash_right)

func empty_cauldron() -> void:
    ingredient_types = EMPTY_CAULDRON.duplicate()
    ingredient_displays.map(func(x): x.modulate = Color.TRANSPARENT)
