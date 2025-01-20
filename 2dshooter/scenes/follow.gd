extends State

# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	print("in follow")
	owner.set_physics_process(true)
	animation_player.play("walk")

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	var distance = owner.direction.length()
	if distance < 30 && (Time.get_ticks_msec() - get_parent().time_start) / 1000.0 > 0.5:
		get_parent().change_state("Attack")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
