extends Node2D

@onready var current_state: State
@onready var previous_state: State
@onready var time_start = Time.get_ticks_msec()

func _ready():
	current_state = get_child(0) as State
	previous_state = current_state
	current_state.enter()

func change_state(state):
	current_state = find_child(state) as State
	current_state.enter()
	
	previous_state.exit()
	previous_state = current_state
