class_name LaunchedIngredient extends Sprite2D

const LAUNCH_HEIGHT: float = 100

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

    position_tween = create_tween()
    position_tween.tween_method(jump_tween.bind(start_position, end_position), 0.0, 1.0, duration)

    visual_tween = create_tween()
    visual_tween.tween_property(self, "rotation_degrees", rotation_degrees + 90, duration)
    visual_tween.set_ease(Tween.EASE_IN)
    visual_tween.set_trans(Tween.TRANS_CUBIC)
    visual_tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, duration)

    visual_tween.tween_callback(callback)

func jump_tween(progress: float, start_position: Vector2, end_position: Vector2):
    var new_x = start_position.x * (1 - progress) + end_position.x * progress
    var new_y = (progress - .5) ** 2 * (LAUNCH_HEIGHT * 4) + (start_position.y - LAUNCH_HEIGHT)
    global_position.x = new_x
    global_position.y = new_y
