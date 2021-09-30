extends Node2D

export (String) var color
var is_matched
var is_counted
var selected = false
var target_position = Vector2.ZERO

var Effects = null
var dying = false
var wiggle = 0.0
export var wiggle_amount = 3

export var transparent_time = 1.0
export var scale_time = 1.5
export var rot_time = 1.5

var sound1 = get_node_or_null("res://Assets/1.wav")
var sound2 = get_node_or_null("res://Assets/2.wav")
var sound3 = get_node_or_null("res://Assets/3.wav")

var Coin = preload("res://Coin/Coin.tscn")

func _ready():
	$Select.texture = $Sprite.texture
	$Select.scale = $Sprite.scale

func _physics_process(_delta):
	if dying:
		queue_free()
	elif position != target_position:
		position = target_position
	if selected:
		$Select.show()
		$Selected.emitting = true
	else:
		$Select.hide()
		$Selected.emitting = false

func generate(pos):
	position = Vector2(pos.x,-100)
	target_position = pos
	if sound2 == null:
		sound2 = get_node_or_null("/root/Game/2")
	if sound2 != null:
		sound2.play()

func move_piece(change):
	target_position = target_position + change
	if sound3 == null:
		sound3 = get_node_or_null("/root/Game/3")
	if sound3 != null:
		sound3.play()

func die():
	dying = true;
	if sound1 == null:
		sound1 = get_node_or_null("/root/Game/1")
	if sound1 != null:
		sound1.play()
	if Effects == null:
		Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		var coin = Coin.instance()
		coin.position = target_position
		Effects.add_child(coin)
