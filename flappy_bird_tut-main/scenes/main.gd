extends Node

@export var pipe_scene: PackedScene

var game_running: bool
var game_over: bool
var scroll: int
var score: int
var SCROLL_SPEED: int = 4
var screen_size: Vector2i
var ground_height: int
var pipes: Array = []
const PIPE_DELAY: int = 500
const PIPE_RANGE: int = 100
var pipe_direction: int = 1  # 1 untuk naik, -1 untuk turun
var pipespeed: int
var bird_node: Node2D
var banteng_node: Node2D
var isalive: bool = true
var bull_speed: int = 250
var bull_stopped: bool = false
var initial_bull_position: Vector2
var throw_direction: Vector2 = Vector2.ZERO  # Arah dan kekuatan lemparan burung
var throw_speed: int = 1500  # Kecepatan lemparan burung
var sfx_played: bool = false  # Flag untuk memastikan sfx hanya diputar sekali

func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	bird_node = get_node("Bird")
	banteng_node = get_node("Banteng")
	initial_bull_position = banteng_node.position  # Simpan posisi awal banteng
	new_game()

func new_game():
	reset_variables()
	reset_bird()
	reset_bull()
	generate_pipes()

func reset_variables():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	SCROLL_SPEED = 4
	%Bird.GRAVITY = 2000
	$ScoreLabel.text = "SCORE: " + str(score)
	$GameOver.hide()
	get_tree().call_group("pipes", "queue_free")
	pipes.clear()
	$message.visible = false
	isalive = true
	bull_stopped = false
	sfx_played = false  # Reset sfx_played

func reset_bird():
	$Bird.reset()

func reset_bull():
	banteng_node.position = initial_bull_position  # Reset posisi banteng

func _input(event):
	if not game_over and Input.is_action_just_pressed("flap"):
		process_input()

func process_input():
	if not game_running:
		start_game()
	elif $Bird.flying:
		$Bird.flap()
		check_top()

func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start()

func _process(delta):
	if game_running:
		update_scroll()
		move_ground()
		move_pipes()
	update_ui()
	handle_bird_movement(delta)

func update_scroll():
	scroll += SCROLL_SPEED
	if scroll >= screen_size.x:
		scroll = 0

func move_ground():
	$Ground.position.x = -scroll

func move_pipes():
	update_pipe_speed()
	for pipe in pipes:
		move_pipe(pipe)

func update_pipe_speed():
	if score > 50:
		pipespeed = 3
	elif score > 25:
		pipespeed = 2
	elif score > 10:
		pipespeed = 1
	else:
		pipespeed = 0

func move_pipe(pipe):
	pipe.position.x -= SCROLL_SPEED
	pipe.position.y += pipespeed * pipe_direction
	check_pipe_limits(pipe)

func check_pipe_limits(pipe):
	if pipe.position.y <= 0:
		pipe.position.y = 0
		pipe_direction = 1  # Change direction to up
	elif pipe.position.y >= screen_size.y - ground_height:
		pipe.position.y = screen_size.y - ground_height
		pipe_direction = -1  # Change direction to down

func update_ui():
	$speed.text = "speed: " + str(SCROLL_SPEED)
	$gravity.text = "gravity: " + str(%Bird.GRAVITY)

func handle_bird_movement(delta):
	if not isalive and not bull_stopped:
		move_bull_towards_bird()
	elif not isalive:
		move_bird(delta)

func move_bird(delta):
	bird_node.position += throw_direction * delta
	throw_direction.y += %Bird.GRAVITY * delta

func _on_pipe_timer_timeout():
	generate_pipes()

func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)

func scored(score_value: int, score_val: int):
	score += 1
	$ScoreLabel.text = "SCORE: " + str(score)
	if score_value == 4 and score_val == 2000:
		SCROLL_SPEED = 4
		%Bird.GRAVITY = 2000
	else:
		SCROLL_SPEED += score_value
		%Bird.GRAVITY += score_val

func check_top():
	if $Bird.position.y < 0:
		$Bird.falling = true
		stop_game()

func stop_game():
	$PipeTimer.stop()
	$GameOver.show()
	$Bird.flying = false
	game_running = false
	game_over = true
	display_game_over_message()
	play_banteng_sfx()

func play_banteng_sfx():
	if not sfx_played:
		%sfxbanteng.playing = true
		sfx_played = true  # Tandai bahwa sfx sudah diputar

func display_game_over_message():
	if score == 16:
		$message.text = "clan terbesar masa cuma 16"
	elif score == 24:
		$message.text = "kamu telah di dzolimi, imam mahdi turun ke bumi"
	$message.visible = true

func bird_hit():
	$Bird.falling = true
	isalive = false
	stop_game()

func _on_ground_hit():
	$Bird.falling = false
	isalive = false
	stop_game()


func _on_game_over_restart():
	new_game()

func move_bull_towards_bird():
	var bird_position = bird_node.position
	var bull_position = banteng_node.position
	var direction = (bird_position - bull_position).normalized()
	banteng_node.position += direction * bull_speed * get_process_delta_time()
	if banteng_node.position.distance_to(bird_position) < 10:
		bull_stopped = true
		banteng_node.position = bird_position
		throw_direction = Vector2(0.1, -1).normalized() * throw_speed
		isalive = false
