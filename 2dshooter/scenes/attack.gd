extends State

func enter():
	super.enter()
	animation_player.play("attack")
	
func transition():
	if !animation_player.is_playing():
		if owner.direction.length() > 30:
			get_parent().change_state("Follow")
