extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0
signal baterboniadeath
var hp=5
var gravity = ProjectSettings.get_setting("physics/2d/default_graivty")
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var timer: Timer = $Timer
@onready var hit_bat: Area2D = $"hit bat"


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("punch bat"):
		cpu_particles_2d.emitting = true
		#timer.start()
		hit_bat.monitoring = true
		await get_tree().create_timer(0.5).timeout
		hit_bat.monitoring = false
func _physics_process(delta: float) -> void:
	# Animations
	if (velocity.x > 1 || velocity.x < -1): 
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
	
	# Add the gravity.
	if not is_on_floor():	
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump bat") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left bat", "right bat")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

func minus():
	hp-=1
	print("Baterbonia HP: ", hp)
	if hp==0:
		baterboniadeath.emit()
		queue_free()

func _on_hit_bat_body_entered(body: Node2D) -> void:
	body.minus()
	print("orld")

func _on_hurt_bat_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	hit_bat.monitoring = false
	pass # Replace with function body.
