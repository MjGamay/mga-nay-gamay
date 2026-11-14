extends Node2D

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_baterbonia_baterboniadeath() -> void:
	pass # Replace with function body.
	print("rene won")
	timer.start()
	label.show()
func _on_rene_renedeath() -> void:
	pass # Replace with function body.
	print("baterbonia won")
	timer.start()
	label.show()

func _on_timer_timeout() -> void:
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://node_2d.tscn")
