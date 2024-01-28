extends Sprite2D

const fps:int = 20
var timer:float = 60/fps

# Called when the node enters the scene tree for the first time.
func _ready():
	frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if timer < 0 and frame != 16:
		frame += 1
		timer = 60/fps
	timer -= 1
	if frame == 16:
		var collision = get_parent().find_child("CollisionShape2D")
		hide()
		if collision != null: collision.queue_free()
	if get_parent().find_child("ExplosionSound").playing == false:
		get_parent().queue_free()
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		area.get_parent().Die()
