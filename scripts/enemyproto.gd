extends CharacterBody3D

@export var WalkSpeed: float = 4.0
@export var RunSpeed: float = 4.0
@export var AttackReach: float = 1.5

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

var player: CharacterBody3D = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	
func _porcess(delta: float) -> void:
	navigation_agent.set_target_position(player.global_position)
	
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z))
	
	if player.global_position.distance_to(global_position) < AttackReach:
		player.health_component.damage(1.0)
		
func _physics_process(delta: float) -> void:
	process_move()
	
func process_move() -> void:
	#if navigation_agent.is_navigation_finished():
		#return
		
	#var next_position: Vector3 = navigation_agent.get_next_path_position()
	#velocity = golbal_postition.direction_to(next_position) = MoveSpeed
	
	move_and_slide()
	
func on_death() -> void:
	queue_free()
