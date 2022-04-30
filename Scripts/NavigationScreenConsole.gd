extends Node2D

var onTrack = true
var currDegree = 0


func _process(delta):
	if(currDegree != 0):
		onTrack = false
	else:
		onTrack	= true
		
	if(onTrack):
		finishNavEvent()

func setNavEvent(degree: int, left: bool):
	var string = ""
	if(left):
		currDegree = -degree
		string = "left"
	else:
		currDegree = degree
		string = "right"
	$Control/NavigationContainer/SubtitleContainer/Label.text = "OBSTRUCTION DETECTED\n" + "Navigate " + str(degree) + " degrees " + string
	
func finishNavEvent():
	$Control/NavigationContainer/SubtitleContainer/Label.text = ""
	pass

func rotateRight(degree: int):
	$ShipDisplay.rotation_degrees += degree
	currDegree += degree
	
	
func rotateLeft(degree: int):
	$ShipDisplay.rotation_degrees -= degree
	currDegree -= degree
