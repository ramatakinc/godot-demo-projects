extends KinematicBody2D

const MOTION_SPEED = 160 # Pixels/second.
const TAN30DEG = tan(deg2rad(30))

var last_direction = Vector2(1, 0)
var anim_directions = {

	"idle": [ # list of [animation name, horizontal flip]
		["side_right_idle", false],
		["45front_right_idle", false],
		["front_idle", false],
		["45front_left_idle", false],
		["side_left_idle", false],
		["45back_left_idle", false],
		["back_idle", false],
		["45back_right_idle", false],
		],

	"walk": [
		["side_right_walk", false],
		["45front_right_walk", false],
		["front_walk", false],
		["45front_left_walk", false],
		["side_left_walk", false],
		["45back_left_walk", false],
		["back_walk", false],
		["45back_right_walk", false],
	],
}


func _physics_process(_delta):
	var motion = Vector2()
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	motion.y *= TAN30DEG
	motion = motion.normalized() * MOTION_SPEED
	#warning-ignore:return_value_discarded
	var dir = move_and_slide(motion)

	if dir.length() > 0:
		last_direction = dir
		update_animation("walk")
	else:
		update_animation("idle")

func update_animation(anim_set):

	var angle = rad2deg(last_direction.angle()) + 22.5
	var slice_dir = floor(angle / 45)

	$AnimatedSprite.play(anim_directions[anim_set][slice_dir][0])
	$AnimatedSprite.flip_h = anim_directions[anim_set][slice_dir][1]
