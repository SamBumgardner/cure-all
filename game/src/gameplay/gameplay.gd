class_name Gameplay extends Node2D

@onready var player: Sprite2D = $Player
@onready var held_ingredient: Sprite2D = $Player/HeldIngredient

@onready var hud: Hud = $Hud
@onready var cauldrons: Array[Node] = $Hud/Cauldrons.get_children()

var queue_helper: QueueHelper = QueueHelper.new()
var held_ingredient_type: Ingredient.TYPES:
    set(new_value):
        held_ingredient_type = new_value
        held_ingredient.texture = load(Ingredient.INGREDIENT_ICON_FORMAT % Ingredient.INGREDIENT_NAMES[held_ingredient_type])

var cauldron_anchors: Array[Node]
var current_player_cauldron_i: int:
    set(new_value):
        current_player_cauldron_i = new_value
        player.global_position = cauldron_anchors[current_player_cauldron_i].global_position

func _ready() -> void:
    for i in cauldrons.size():
        cauldrons[i].potion_produced.connect(_on_cauldron_potion_produced.bind(i))

    await get_tree().process_frame
    cauldron_anchors = get_tree().get_nodes_in_group("brewer_anchors")
    cauldron_anchors.sort_custom(func(a, b): return a.global_position.x < b.global_position.x)

    current_player_cauldron_i = cauldron_anchors.size() / 2
    take_next_ingredient()
    hud.update_potion_queue(queue_helper.queued_potions)

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_left"):
        current_player_cauldron_i = \
            current_player_cauldron_i - 1 \
            if current_player_cauldron_i != 0 \
            else cauldron_anchors.size() - 1

    if Input.is_action_just_pressed("ui_right"):
        current_player_cauldron_i = (current_player_cauldron_i + 1) % cauldron_anchors.size()

    if Input.is_action_just_pressed("ui_accept"):
        cauldrons[current_player_cauldron_i].add_ingredient(held_ingredient_type, true)
        take_next_ingredient()

    if Input.is_action_just_pressed("ui_cancel"):
        cauldrons[current_player_cauldron_i].add_ingredient(held_ingredient_type, false)
        take_next_ingredient()

func take_next_ingredient():
    held_ingredient_type = queue_helper.cycle_ingredient_queue()
    hud.update_ingredient_queue(queue_helper.queued_ingredients)

func _on_cauldron_potion_produced(
    potion: Potion,
    splash_left: Array[Ingredient.TYPES],
    splash_right: Array[Ingredient.TYPES],
    cauldron_index: int
):
    print_debug("we made a potion with level %s and types %s!" % [potion.level, potion.types])
    var queued_potion = queue_helper.get_front_potion()
    if queued_potion.types[0] in potion.types:
        _matched_queue_potion()

    var left_cauldron = _get_wrapped_cauldron(cauldron_index, -1)
    for ingredient in splash_left:
        left_cauldron.add_ingredient(ingredient, false)
    
    var right_cauldron = _get_wrapped_cauldron(cauldron_index, 1)
    for ingredient in splash_right:
        right_cauldron.add_ingredient(ingredient, true)

func _get_wrapped_cauldron(starting_cauldron_i: int, offset: int) -> Cauldron:
    var new_cauldron_i: int = starting_cauldron_i + offset
    if new_cauldron_i < 0:
        new_cauldron_i += cauldrons.size()
    else:
        new_cauldron_i = new_cauldron_i % cauldrons.size()
    
    return cauldrons[new_cauldron_i]

func _matched_queue_potion():
    queue_helper.cycle_potion_queue()
    hud.update_potion_queue(queue_helper.queued_potions)
    # score points
