extends Node2D

onready var message = $Control/ConsoleContainer/Message

func loadText(text: String):
	message.text = "/-> " + text;
	


