extends CharacterBody3D

var player = null

var state_machine

const SPEED = 4.5
const ATTACK_RANGE = 2.0
const DAMAGE = 10.0

@export var player_path: NodePath

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree2
@onready var collisionshape = $CollisionShape3D
@onready var raycast = $RayCast

func _ready() -> void:
	player = get_node(player_path)
	state_machine = anim_tree.get("parameters/playback")
	
func _physics_process(_delta: float) -> void:
	match state_machine.get_current_node():
		"animations_idle":
			raycast.look_at(player.global_position, Vector3.UP)
			if raycast.is_colliding():
				if raycast.get_collider() == player:
					anim_tree.set("parameters/conditions/animations_run", true)
		"animations_run":
			if target_in_range():
				velocity = Vector3.ZERO
				anim_tree.set("parameters/conditions/animations_attack", true)
				anim_tree.set("parameters/conditions/animations_run", false)
			else:
				nav_agent.set_target_position(player.global_position)
				var next_nav_point = nav_agent.get_next_path_position()
				velocity = (next_nav_point - global_position).normalized() * SPEED
				look_at(Vector3(next_nav_point.x, global_position.y, next_nav_point.z), Vector3.UP)
				
				anim_tree.set("parameters/conditions/animations_attack",false)
				anim_tree.set("parameters/conditions/animations_run", true)
			
			move_and_slide()
			
		"animations_attack":
			velocity = Vector3.ZERO
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
			if not target_in_range():
				anim_tree.set("parameters/conditions/animations_attack", false)
				anim_tree.set("parameters/conditions/animations_run", true)
			
func hit_player():
	if target_in_range():
		var dir = global_position.direction_to(player.global_position)
		player.hit(DAMAGE, dir)


func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE 
	
