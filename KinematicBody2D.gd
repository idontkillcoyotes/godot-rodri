extends KinematicBody2D

export (float) var speed = 100
export (float) var gravity = 400

var velocity := Vector2.ZERO
var direction := Vector2.RIGHT

var raycast_derecha : RayCast2D #= $RaycastDerecha
var raycast_izquierda : RayCast2D # = $RaycastIzquierda

onready var timer : Timer = $Timer

func _ready() -> void:
	raycast_derecha = $RaycastDerecha
	raycast_izquierda = $RaycastIzquierda

func _process(delta: float) -> void:
	
	if raycast_derecha.is_colliding():
		direction = Vector2.LEFT
		timer.start()
		set_process(false)
		raycast_derecha.enabled = false
		return
	else:
		raycast_derecha.enabled = true
	
	if raycast_izquierda.is_colliding():
		direction = Vector2.RIGHT
		timer.start()
		set_process(false)
		raycast_izquierda.enabled = false
		return
	else:
		raycast_izquierda.enabled = true
	
	velocity = direction * speed 
	velocity += (gravity * Vector2.DOWN)
	move_and_slide(velocity)


func _on_Timer_timeout() -> void:
	set_process(true)
