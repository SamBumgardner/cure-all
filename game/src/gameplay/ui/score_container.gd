class_name ScoreContainer extends Control

const SCORE_FORMAT = "%06d"

@onready var score_value = $ScoreValue

var display_score_value: int

func update_score(new_value: int):
    display_score_value = new_value
    score_value.text = SCORE_FORMAT % display_score_value
