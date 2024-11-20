class_name Cauldron extends Control

signal potion_produced(
    potion: Potion,
    splash_left: Array[Ingredient.TYPES],
    splash_right: Array[Ingredient.TYPES]
)

const MAX_INGREDIENTS: int = 4
const MIN_MATCH: int = 2

@export var ingredient_container: Node

@onready var ingredient_displays: Array[Node] = ingredient_container.get_children()
var ingredient_types: Array[int] = []

func _ready() -> void:
    ingredient_displays.map(func(x): x.hide())

func add_ingredient(ingredient_type: Ingredient.TYPES) -> void:
    if ingredient_types.size() < MAX_INGREDIENTS:
        ingredient_types.push_back(ingredient_type)

        var current_ingredient: TextureRect = ingredient_displays[ingredient_types.size() - 1] as TextureRect
        current_ingredient.show()
        var ingredient_name = Ingredient.INGREDIENT_NAMES[ingredient_type]
        current_ingredient.texture = load(Ingredient.INGREDIENT_ICON_FORMAT % ingredient_name)

        if ingredient_types.size() == MAX_INGREDIENTS:
            full_brew()

func full_brew() -> void:
    var ingredient_counts: Array[Array] = []
    for i in Ingredient.TYPES.size():
        ingredient_counts.push_back([])
    
    var potion: Potion = Potion.new(-1, [])
    for i in ingredient_types.size():
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
    ingredient_types.clear()
    ingredient_displays.map(func(x): x.hide())
