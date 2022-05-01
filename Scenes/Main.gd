extends Spatial

onready var screen_radar = $Ship/Console/Screen/GUI/ScannerConsole
onready var screen_nav = $Ship/Console/Screen/GUI/NavigationScreenConsole
onready var screen_power = $Ship/Console/Screen/GUI/EnergyDisplayConsole
onready var screen_message = $Ship/Console/Screen/GUI/MessageScreenConsole
onready var blackscreen = $Ship/Console/Screen/GUI/blackscreen

var last_screen
var console_on = true
var console_working = true

func _ready():
	last_screen = screen_radar

func _process(_delta):
	pass
		

func push(button_name):
	if console_working:
		match button_name:
			"Toggle Lights":
				if $Ship/Console/SpotLight.visible:
					$Ship/Console/SpotLight.visible = false
				else:
					$Ship/Console/SpotLight.visible = true
			"Switch to Radar":
				screen_nav.hide()
				screen_power.hide()
				screen_message.hide()
				screen_radar.show()
				$Ship/Console/ScreenLight.show()
				last_screen = screen_radar
				if !console_on:
					console_on = true
			"Switch to Navigation":
				screen_nav.show()
				screen_power.hide()
				screen_message.hide()
				screen_radar.hide()
				$Ship/Console/ScreenLight.show()
				last_screen = screen_nav
				if !console_on:
					console_on = true
			"Switch to Power":
				screen_nav.hide()
				screen_power.show()
				screen_message.hide()
				screen_radar.hide()
				$Ship/Console/ScreenLight.show()
				last_screen = screen_power
				if !console_on:
					console_on = true
			"Toggle Console":
				if console_on:
					screen_nav.hide()
					screen_power.hide()
					screen_message.hide()
					screen_radar.hide()
					blackscreen.show()
					$Ship/Console/ScreenLight.hide()
					console_on = false
				else:
					screen_nav.hide()
					screen_power.hide()
					screen_message.hide()
					screen_radar.hide()
					blackscreen.hide()
					last_screen.show()
					$Ship/Console/ScreenLight.show()
					console_on = true
			"Turn Right 15°":
				if screen_nav.visible:
					screen_nav.rotateRight(15)
					$Env/WorldEnvironment.rotateSkyRight()
					$Env/DirectionalLight.rotation_degrees.y += 15
			"Turn Left 15°":
				if screen_nav.visible:
					screen_nav.rotateLeft(15)
					$Env/WorldEnvironment.rotateSkyLeft()
					$Env/DirectionalLight.rotation_degrees.y -= 15
			"Recieve Transmission":
				screen_nav.hide()
				screen_power.hide()
				screen_message.show()
				screen_radar.hide()
				screen_message.loadText("")
			"Gamma Pulse":
				if !screen_radar.selecting:
					screen_radar.ping()
				print("Pressing pulse button")
			"Identify as Planetary Mass":
				if screen_radar.selecting:
					print("Selecting Planetary Mass")
					screen_radar.identifyAnomaly() # Pass the chosen type - check if correct in Globals
				else:
					pass
			"Identify as Debritus":
				if screen_radar.selecting:
					print("Selecting Debritus")
					screen_radar.identifyAnomaly() 
				else:
					pass
			"Identify as Alien Organism":
				if screen_radar.selecting:
					print("Selecting Alien Organism")
					screen_radar.identifyAnomaly() 
				else:
					pass
			"Identify as Unknown":
				if screen_radar.selecting:
					print("Selecting Unknown")
					screen_radar.identifyAnomaly() 
				else:
					pass
	else:
		pass

func triggerBlackFog():
	$blackfog_mid.emitting = true
	$blackfog_L.emitting = true
	$blackfog_R.emitting = true
	screen_nav.hide()
	screen_power.hide()
	screen_message.hide()
	screen_radar.hide()
	blackscreen.hide()
	$Ship/Console/Screen/GUI/Static.show()
	$Audio/console_glitch.play()
	$Env/WorldEnvironment.setAmbientLight(1)
	$Env/DirectionalLight/AnimationPlayer.play("dim")
	

func _on_powertick_timeout():
	if console_on:
		screen_power.useEnergy(5)
	if $Ship/Console/SpotLight.visible:
		screen_power.useEnergy(5)
	$powertick.start()
