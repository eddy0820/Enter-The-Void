extends Spatial

var rng = RandomNumberGenerator.new()

onready var anomalies = [
	preload("res://Scenes/Anomalies/Cube.tscn"),
	preload("res://Scenes/Anomalies/Flower.tscn"),
	preload("res://Scenes/Anomalies/Skull.tscn"),
	preload("res://Scenes/Anomalies/Planet_desert.tscn"),
]


func spawnAnomaly():
	rng.randomize()
	var spawner
	var sideRoll = rng.randi_range(1,2)
	if sideRoll == 1:
		spawner = $AnomalySpawner
	else:
		spawner = $AnomalySpawner2
	
	var random_anomaly = anomalies[rng.randi_range(0, anomalies.size() - 1)]
	
	spawner.add_child(random_anomaly.instance())
	

func handleStart():
	$AnomalyTimer.start(15)
	


func _on_AnomalyTimer_timeout():
	rng.randomize()
	var randomCD = rng.randi_range(30,45)
	spawnAnomaly()
	$AnomalyTimer.start(randomCD)
	
