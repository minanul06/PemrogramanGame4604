extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func reset():
	pass
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$AnimatedSprite2D.play()
	#$AnimatedSprite2D.stop()
