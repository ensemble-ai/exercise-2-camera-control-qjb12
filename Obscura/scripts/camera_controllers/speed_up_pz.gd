class_name SpeedupPushZone
extends CameraControllerBase

@export var push_ratio:float = 0.5
@export var pushbox_top_left:Vector2 = Vector2(-10, 7)
@export var pushbox_bottom_right:Vector2 = Vector2(10, -7)
@export var speedup_zone_top_left:Vector2 = Vector2(-5, 3)
@export var speedup_zone_bottom_right:Vector2 = Vector2(5, -3)

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

	var camera_velocity = Vector3.ZERO
	var target_speed = target.velocity.length()
	
	var diff_between_left_edges = target.global_position.x - (global_position.x + pushbox_top_left.x)
	var diff_between_left_edges_sz = target.global_position.x - (global_position.x + speedup_zone_top_left.x)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges
	elif (diff_between_left_edges_sz < 0) and (diff_between_left_edges > 0) and (target_speed > 0) and (target.velocity.x < 0):
		camera_velocity.x = -target_speed * push_ratio
		global_position += camera_velocity * delta
	#right
	var diff_between_right_edges = target.global_position.x - (global_position.x + pushbox_bottom_right.x)
	var diff_between_right_edges_sz = target.global_position.x - (global_position.x + speedup_zone_bottom_right.x)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges
	elif (diff_between_right_edges_sz > 0) and (diff_between_right_edges < 0) and (target_speed > 0) and (target.velocity.x > 0):
		camera_velocity.x = target_speed * push_ratio
		global_position += camera_velocity * delta
	#top
	var diff_between_top_edges = target.global_position.z - (global_position.z + pushbox_top_left.y)
	var diff_between_top_edges_sz = target.global_position.z - (global_position.z + speedup_zone_top_left.y)
	if diff_between_top_edges > 0:
		global_position.z += diff_between_top_edges
	elif (diff_between_top_edges_sz > 0) and (diff_between_top_edges < 0) and (target_speed > 0) and (target.velocity.z > 0):
		camera_velocity.z = target_speed * push_ratio
		global_position += camera_velocity * delta
	#bottom
	var diff_between_bottom_edges = target.global_position.z - (global_position.z + pushbox_bottom_right.y)
	var diff_between_bottom_edges_sz = target.global_position.z - (global_position.z + speedup_zone_bottom_right.y)
	if diff_between_bottom_edges < 0:
		global_position.z += diff_between_bottom_edges
	elif (diff_between_bottom_edges_sz < 0) and (diff_between_bottom_edges > 0) and (target_speed > 0) and (target.velocity.z < 0):
		camera_velocity.z = -target_speed * push_ratio
		global_position += camera_velocity * delta

	# Allow vertical movement within the pushbox
	if target.global_position.y < global_position.y + pushbox_top_left.y:
		global_position.y = target.global_position.y - pushbox_top_left.y
	elif target.global_position.y > global_position.y + pushbox_bottom_right.y:
		global_position.y = target.global_position.y - pushbox_bottom_right.y


	super(delta)

func draw_logic() -> void:
	var immediate_mesh := ImmediateMesh.new()
	var material := StandardMaterial3D.new()
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	
	# Draw the pushbox border
	var pushbox_top_left_3d = Vector3(pushbox_top_left.x, 0, pushbox_top_left.y)
	var pushbox_top_right_3d = Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y)
	var pushbox_bottom_left_3d = Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y)
	var pushbox_bottom_right_3d = Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y)
	
	# Top edge
	immediate_mesh.surface_add_vertex(pushbox_top_left_3d)
	immediate_mesh.surface_add_vertex(pushbox_top_right_3d)
	
	# Right edge
	immediate_mesh.surface_add_vertex(pushbox_top_right_3d)
	immediate_mesh.surface_add_vertex(pushbox_bottom_right_3d)
	
	# Bottom edge
	immediate_mesh.surface_add_vertex(pushbox_bottom_right_3d)
	immediate_mesh.surface_add_vertex(pushbox_bottom_left_3d)
	
	# Left edge
	immediate_mesh.surface_add_vertex(pushbox_bottom_left_3d)
	immediate_mesh.surface_add_vertex(pushbox_top_left_3d)
	
	# Draw the speedup zone border
	var speedup_zone_top_left_3d = Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y)
	var speedup_zone_top_right_3d = Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y)
	var speedup_zone_bottom_left_3d = Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y)
	var speedup_zone_bottom_right_3d = Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y)
	
	# Top edge
	immediate_mesh.surface_add_vertex(speedup_zone_top_left_3d)
	immediate_mesh.surface_add_vertex(speedup_zone_top_right_3d)
	
	# Right edge
	immediate_mesh.surface_add_vertex(speedup_zone_top_right_3d)
	immediate_mesh.surface_add_vertex(speedup_zone_bottom_right_3d)
	
	# Bottom edge
	immediate_mesh.surface_add_vertex(speedup_zone_bottom_right_3d)
	immediate_mesh.surface_add_vertex(speedup_zone_bottom_left_3d)
	
	# Left edge
	immediate_mesh.surface_add_vertex(speedup_zone_bottom_left_3d)
	immediate_mesh.surface_add_vertex(speedup_zone_top_left_3d)
	
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
