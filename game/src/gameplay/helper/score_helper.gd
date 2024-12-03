class_name ScoreHelper extends Node

signal mult_increased(new_multiplier: int)
signal mult_reset(new_multiplier: int)
signal rank_increased(new_rank: int)
signal score_increased(new_score: int)

const MULT_BASE: float = 1.0
const POTION_MULT_INCREASE: float = .1

const POTION_RANK_POINTS: int = 1
const RANK_TIER_THRESHOLDS: Array[float] = [
    5,
    10,
    15,
]

const POTION_LEVEL_SCORE: float = 100
const POTION_RANK_TIER_SCORE: float = 100
const ORDER_SCORE_TIERS: Array[float] = [
    100,
    200,
    300,
    500,
]

var multiplier: float = MULT_BASE
var multiplier_expiration_max: float = 5.0
var multiplier_expiration: float = -1.0

var score: int = 0

var rank_points: int = 0
var rank_tier: int = 0

func potion_completed(potion: Potion):
    # multiplier / combo logic
    multiplier_increase(POTION_MULT_INCREASE)

    # Difficulty level increase logic
    #  Granular difficulty levels are hidden from player, but "stars" build up in a visible way.
    #  Point scaling is small for granular changes, with boosts to base value when hitting higher levels
    rank_increase(POTION_RANK_POINTS)

    # Score points for potion quality
    var potion_score_value: float = (potion.level + 1) * POTION_LEVEL_SCORE + POTION_RANK_TIER_SCORE * rank_tier
    score_increase(potion_score_value * multiplier)

func order_fulfilled():
    # Score bonus points for fulfilling order, 
    #  increased according to difficulty level
    var order_score_value: float = ORDER_SCORE_TIERS[rank_tier]
    score_increase(order_score_value * multiplier)

func multiplier_increase(increase_by: float):
    multiplier += increase_by
    mult_increased.emit(multiplier)

    multiplier_expiration = multiplier_expiration_max

func multiplier_reset():
    multiplier = MULT_BASE
    mult_reset.emit(multiplier)

func rank_increase(increase_by: int):
    rank_points += increase_by

    var old_rank_tier = rank_tier
    while rank_tier < RANK_TIER_THRESHOLDS.size() and RANK_TIER_THRESHOLDS[rank_tier] < rank_points:
        rank_tier += 1
    
    if old_rank_tier != rank_tier:
        rank_increased.emit(rank_tier - old_rank_tier)

func score_increase(increase_by: float):
    score += floor(increase_by)
    score_increased.emit(score)

func _process(delta: float) -> void:
    if multiplier > MULT_BASE:
        if multiplier_expiration > 0:
            multiplier_expiration -= delta
        else:
            multiplier_reset()
