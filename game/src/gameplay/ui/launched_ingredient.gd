class_name LaunchedIngredient extends Sprite2D

const LAUNCH_HEIGHT: Vector2 = Vector2(0, -100)

var position_tween: Tween
var visual_tween: Tween

func _ready() -> void:
    modulate = Color.TRANSPARENT

func launch(ingredient_type: Ingredient.TYPES, start_position: Vector2, end_position: Vector2,
        duration: float, callback: Callable):
    if position_tween != null and position_tween.is_valid():
        position_tween.kill()
        visual_tween.kill()
    
    texture = load(Ingredient.INGREDIENT_ICON_FORMAT % Ingredient.INGREDIENT_NAMES[ingredient_type])
    rotation_degrees = 0
    modulate = Color.WHITE
    global_position = start_position

    var midway_position: Vector2 = (start_position + end_position) / 2 + LAUNCH_HEIGHT
    position_tween = create_tween()
    position_tween.set_trans(Tween.TRANS_CUBIC)
    position_tween.set_ease(Tween.EASE_OUT)
    position_tween.tween_property(self, "global_position", midway_position, duration / 2)
    position_tween.set_ease(Tween.EASE_IN)
    position_tween.tween_property(self, "global_position", end_position, duration / 2)

    visual_tween = create_tween()
    visual_tween.tween_property(self, "modulate", Color.TRANSPARENT, duration)
    visual_tween.parallel().tween_property(self, "rotation_degrees", rotation_degrees + 90, duration)

    visual_tween.tween_callback(callback)
