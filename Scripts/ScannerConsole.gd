extends Node2D

var selecting = false
var currentAnomalyType: String

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


func detectAnomaly(mass: int, velocity: int, gammaReaction: bool, type: String):
	$Radar.hide()
	$AnomalyDetected.show()
	selecting = true
	
	currentAnomalyType = type
	
	$AnomalyDetected/VBoxContainer/Mass.text = "Mass: " + str(mass) + " hg"
	$AnomalyDetected/VBoxContainer/Velocity.text = "Velocity: " + str(velocity) + " cm/s"
	if gammaReaction:
		$AnomalyDetected/VBoxContainer/Gammareaction.text = "Gamma: YES"
	else:
		$AnomalyDetected/VBoxContainer/Gammareaction.text = "Gamma: NO"
	$AnomalyDetected/VBoxContainer/IndentifyAnomaly.text = type


func identifyAnomaly(selection):
	selecting = false
	
	if selection == currentAnomalyType:
		$Radar.show()
		$AnomalyDetected.hide()
		get_parent().get_parent().get_parent().get_parent().get_parent().energyRestore()
		get_parent().get_parent().get_parent().get_parent().get_parent().clearAnomalies()
	else:
		Globals.death_message = "An anomaly was misidentified"
		get_parent().get_parent().get_parent().get_parent().get_parent().triggerBlackFog()



func _on_Timer_timeout():
	$Radar/scanFailLabel.hide()
