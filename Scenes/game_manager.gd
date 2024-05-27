extends Node

@onready var points_label = $"../UI/Panel/points label"


var points = 0

func add_point():
	points += 1
	print(points)
	points_label.text = "Codes Obtained: " + str(points)
	
	
