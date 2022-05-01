extends Spatial


func _process(delta):
	rotation_degrees.y += .2
	
	if self.visible == true && $crystalBlue/crystalchime.playing == false:
		$crystalBlue/crystalchime.playing = true
		$crystalGreen/crystalchime.playing = true
		$crystalPurple/crystalchime.playing = true
		$crystalRed/crystalchime.playing = true

