class_name LerpSmoothing
extends CameraControllerBase

@export var lead_speed:float = 5.0
@export var catchup_speed:float = 5.0
@export var leash_distance:float = 15.0

var last_input_direction:Vector3 = Vector3.ZERO
var is_moving:bool = false

func _ready() -> void:
	super()
	# Set the initial position above the target
	position = target.position + Vector3(0, dist_above_target, 0)
	# Set the rotation to look directly down
	rotation_degrees = Vector3(-90, 0, 0)

func _process(delta: float) -> void:
	if !current:
		return
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position + Vector3(0, dist_above_target, 0)
	var cpos = global_position
	
	# Calculate the direction based on the player's input
	var input_direction = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		input_direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		input_direction.z += 1
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	
	# Normalize the input direction
	if input_direction != Vector3.ZERO:
		input_direction = input_direction.normalized()
		last_input_direction = input_direction
		is_moving = true
	else:
		is_moving = false
	
	# Determine the speed to move the camera
	var speed = lead_speed
	var lead_position = tpos
	if is_moving:
		lead_position += last_input_direction * leash_distance
	else:
		speed = catchup_speed
	
	# Interpolate the camera's position towards the lead position
	global_position = cpos.lerp(lead_position, speed * delta)
	
	super(delta)

func draw_logic() -> void:
	var immediate_mesh := ImmediateMesh.new()
	var material := StandardMaterial3D.new()
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	
	# Draw horizontal line
	immediate_mesh.surface_add_vertex(Vector3(-5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(5, 0, 0))
	
	# Draw vertical line
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 5))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.material_override = material
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# Mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
