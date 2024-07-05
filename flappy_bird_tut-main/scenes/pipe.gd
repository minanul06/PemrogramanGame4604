extends Area2D

signal hit
signal scored(score_value: int)
var random_image_path1
var random_image_path2

func _on_body_entered(body):
	hit.emit()

func _on_score_area_body_entered(body):
	print(random_image_path1)
	var speed
	var grav
	if random_image_path1 == "res://assets/artis/nisa1.png":
		speed = 1
		grav = 0
		%sound1.playing=true
		pass
	elif random_image_path1 == "res://assets/artis/imin1.png":
		speed = -1
		grav = 0
		%sound2.playing=true
		pass
	elif random_image_path1 == "res://assets/artis/janggar1.png":
		speed = 0
		grav = 250
		%sound3.playing=true
		pass
	elif random_image_path1 == "res://assets/artis/mamud1.png":
		speed = 0
		grav = -250
		%sound4.playing=true
		pass
	elif random_image_path1 == "res://assets/artis/gaban1.png":
		speed = 4
		grav = 2000
		%sound5.playing=true
		pass
	else:
		speed = 0
		grav = 0
		pass
	scored.emit(speed,grav)

func _on_score_area_body_entered2(body):
	print(random_image_path2)
	var speed
	var grav
	if random_image_path2 == "res://assets/artis/nisa1.png":
		speed = 1
		grav = 0
		%sound1.playing=true
		pass
	elif random_image_path2 == "res://assets/artis/imin1.png":
		speed = -1
		grav = 0
		%sound2.playing=true
		pass
	elif random_image_path2 == "res://assets/artis/janggar1.png":
		speed = 0
		grav = 250
		%sound3.playing=true
		pass
	elif random_image_path2 == "res://assets/artis/mamud1.png":
		speed = 0
		grav = -250
		%sound4.playing=true
		pass
	elif random_image_path2 == "res://assets/artis/gaban1.png":
		speed = 4
		grav = 2000
		%sound5.playing=true
		pass
	else:
		speed = 0
		grav = 0
		pass
	scored.emit(speed,grav)

# Properti untuk menyimpan daftar gambar
var images := ["","res://assets/artis/nisa1.png","res://assets/artis/imin1.png","res://assets/artis/janggar1.png","res://assets/artis/mamud1.png","res://assets/artis/gaban1.png"]

# Skala gambar
var image_scale := Vector2(0.05, 0.05)  # Ubah sesuai kebutuhan

func _ready():
	# Memanggil fungsi untuk menampilkan gambar acak saat area siap
	show_random_images()
	

# Fungsi untuk menampilkan gambar acak di area
func show_random_images():
	# Memilih gambar secara acak dari daftar gambar untuk ScoreArea pertama
	random_image_path1 = images[randi() % images.size()]
	# Membuat Sprite2D baru untuk ScoreArea pertama
	var sprite1 = Sprite2D.new()
	# Menyesuaikan posisi titik asal
	sprite1.centered = true  # Mengatur titik asal di tengah sprite
	# Memuat tekstur gambar secara dinamis untuk ScoreArea pertama
	var texture1 = ResourceLoader.load(random_image_path1)
	if texture1:
		sprite1.texture = texture1
		# Menyesuaikan skala gambar
		sprite1.scale = image_scale
		# Menambahkan Sprite ke dalam ScoreArea pertama
		var score_area1 = get_node("ScoreArea")  # Ganti dengan jalur yang benar ke ScoreArea
		score_area1.add_child(sprite1)
	
	# Memilih gambar secara acak dari daftar gambar untuk ScoreArea kedua
	random_image_path2 = images[randi() % images.size()]
	# Membuat Sprite2D baru untuk ScoreArea kedua
	var sprite2 = Sprite2D.new()
	# Menyesuaikan posisi titik asal
	sprite2.centered = true  # Mengatur titik asal di tengah sprite
	# Memuat tekstur gambar secara dinamis untuk ScoreArea kedua
	var texture2 = ResourceLoader.load(random_image_path2)
	if texture2:
		sprite2.texture = texture2
		# Menyesuaikan skala gambar
		sprite2.scale = image_scale
		# Menambahkan Sprite ke dalam ScoreArea kedua
		var score_area2 = get_node("ScoreArea2")  # Ganti dengan jalur yang benar ke ScoreArea2
		score_area2.add_child(sprite2)




