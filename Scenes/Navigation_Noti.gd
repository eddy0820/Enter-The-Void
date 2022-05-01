extends MeshInstance

func _process(_delta):
	if Globals.off_course && $nav_beep.playing == false:
		$nav_beep.playing = true
	if !Globals.off_course:
		$nav_beep.playing = false
