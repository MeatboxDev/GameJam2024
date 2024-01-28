extends CanvasLayer

func ShowMessageGreen(message, timeout = 3.0):
	print("[Green Message]" + message)
	
	var canvas = CanvasLayer.new()
	var panel = PanelContainer.new()
	var label = Label.new()
	
	canvas.size = Vector2(200, 50)
	
	label.modulate = Color(47, 87, 47)
	label.text = message

	canvas.add_child(panel)
	panel.add_child(label)
	
	add_child(canvas)
	get_tree().create_timer(timeout).timeout
	canvas.queue_free()
	

func ShowMessageRed(message, timeout = 3.0):
	pass
	

func ShowMessageWhite(message, timeout = 3.0):
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
