class_name PosLockLerpSmooth
extends CameraControllerBase

@export var follow_speed:float = 5.0
@export var catchup_speed:float = 5.0
@export var leash_distance:float = 10.0

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
	
	# Calculate the distance between the camera and the target
	var distance = cpos.distance_to(tpos)
	
	# Determine the speed to move the camera
	var speed = follow_speed
	if distance > leash_distance:
		speed = catchup_speed
	
	# Interpolate the camera's position towards the target's position
	global_position = cpos.lerp(tpos, speed * delta)
	
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
	mesh_instance.global_position = target.global_position
	
	# Mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
