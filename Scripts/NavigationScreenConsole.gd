extends Node2D


var tempDegree = 0
var requiredDegree = 0

func _process(_delta):
	if int($ShipDisplay.rotation_degrees) % 360 != requiredDegree:
		Globals.off_course = true
		$Control/NavigationContainer/SubtitleContainer/Label.visible = true
	else:
		Globals.off_course = false
		$Control/NavigationContainer/SubtitleContainer/Label.visible = false
		$Control/NavigationContainer/SubtitleContainer/Label.text = "NAVIGATION OFF COURSE"

func setNavEvent(degree: int, left: bool):
	var string = ""
	if(left):
		string = "left"
		requiredDegree = $ShipDisplay.rotation_degrees - degree
	else:
		string = "right"
		requiredDegree = $ShipDisplay.rotation_degrees + degree
	$Control/NavigationContainer/SubtitleContainer/Label.text = "OBSTRUCTION DETECTED\n" + "Navigate " + str(degree) + " degrees " + string
	

func rotateRight(degree: int):
	$ShipDisplay.rotation_degrees += degree
	tempDegree += degree
	
	
func rotateLeft(degree: int):
	$ShipDisplay.rotation_degrees -= degree
	tempDegree -= degree
