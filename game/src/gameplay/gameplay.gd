class_name Gameplay extends Node2D

@onready var player: Sprite2D = $Player
@onready var cauldrons: Array[Node] = $Hud/Cauldrons.get_children()

var cauldron_anchors: Array[Node]
var current_player_cauldron_i: int:
    set(new_value):
        current_player_cauldron_i = new_value
        player.global_position = cauldron_anchors[current_player_cauldron_i].global_position

func _ready() -> void:
    await get_tree().process_frame
    cauldron_anchors = get_tree().get_nodes_in_group("brewer_anchors")
    cauldron_anchors.sort_custom(func(a, b): return a.global_position.x < b.global_position.x)

    current_player_cauldron_i = cauldron_anchors.size() / 2

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_left"):
        current_player_cauldron_i = \
            current_player_cauldron_i - 1 \
            if current_player_cauldron_i != 0 \
            else cauldron_anchors.size() - 1

    if Input.is_action_just_pressed("ui_right"):
        current_player_cauldron_i = (current_player_cauldron_i + 1) % cauldron_anchors.size()

    if Input.is_action_just_pressed("ui_accept"):
        cauldrons[current_player_cauldron_i].add_ingredient("star")
