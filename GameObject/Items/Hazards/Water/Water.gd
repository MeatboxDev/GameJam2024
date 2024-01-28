extends Sprite2D

const fps:int = 2
var timer:float = 60/fps

# Called when the node enters the scene tree for the first time.
func _ready():
	frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if timer < 0:
		if frame != 3: frame += 1
		else: frame = 0
		timer = 60/fps
		return
	timer -= 1
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		area.get_parent().Die()
