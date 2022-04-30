extends Node2D

var selecting = false

func ready():
	$Radar/scanFailLabel.hide()
	selecting = false

func ping():
	Globals.attemptScan(self)
	print("pinging ScannerConsole")

func scanFail():
	print("Scan failed")
	$Radar/Background/Radar/ScanParticle.emitting = true
	$Radar/scanFailLabel.show()
	$Timer.start(3)


func detectAnomaly(mass: int, velocity: int, gammaReaction: bool):
	$Radar.hide()
	$AnomalyDetected.show()
	selecting = true
	
	
	$AnomalyDetected/VBoxContainer/Mass.text = "Mass: " + str(mass) + " hg"
	$AnomalyDetected/VBoxContainer/Velocity.text = "Velocity: " + str(velocity) + " cm/s"
	if gammaReaction:
		$AnomalyDetected/VBoxContainer/Gammareaction.text = "Gamma: YES"
	else:
		$AnomalyDetected/VBoxContainer/Gammareaction.text = "Gamma: NO"


func identifyAnomaly():
	selecting = false
	$Radar.show()
	$AnomalyDetected.hide()



func _on_Timer_timeout():
	$Radar/scanFailLabel.hide()
