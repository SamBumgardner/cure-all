class_name PotionQueue extends HBoxContainer

@onready var queue_icons: Array[TextureRect] = [
    $FirstPotion/VBoxContainer/Icon,
    $SecondPotion/Icon,
    $ThirdPotion/Icon,
]

func set_queue_icon_textures(potions: Array[Potion]):
    for i in queue_icons.size():
        queue_icons[i].texture = load(Potion.POTION_ICON_FORMAT % Ingredient.INGREDIENT_NAMES[potions[i].types[0]])
