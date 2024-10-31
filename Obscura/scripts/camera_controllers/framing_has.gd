class_name FramingHAS
extends CameraControllerBase

@export var top_left:Vector2 = Vector2(-10, 4)
@export var bottom_right:Vector2 = Vector2(10, -4)
@export var autoscroll_speed:Vector3 = Vector3(15, 0, 0)

func _ready() -> void:
	super()
	position = target.position + Vector3(0, dist_above_target, 0)
	rotation_degrees = Vector3(-90, 0, 0)

func _process(delta: float) -> void:
	if !current:
		return
	if draw_camera_logic:
		draw_logic()
	
	# Update the camera position based on autoscroll_speed
	position += autoscroll_speed * delta
	
	# Update the target's position if it touches the left edge of the box
	var left_edge = position.x + top_left.x
	var right_edge = position.x + bottom_right.x
	var top_edge = position.z + top_left.y
	var bottom_edge = position.z + bottom_right.y
	
	# Get the target's position
	var tpos = target.global_position
	
	# Check and adjust the target's position if it goes outside the box
	if tpos.x < left_edge:
		target.global_position.x = left_edge
	if tpos.x > right_edge:
		target.global_position.x = right_edge
	if tpos.z > top_edge:
		target.global_position.z = top_edge
	if tpos.z < bottom_edge:
		target.global_position.z = bottom_edge
	
	super(delta)

func draw_logic() -> void:
	var immediate_mesh := ImmediateMesh.new()
	var material := StandardMaterial3D.new()
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	
	# Draw the frame border box
	var top_left_3d = Vector3(top_left.x, 0, top_left.y)
	var top_right_3d = Vector3(bottom_right.x, 0, top_left.y)
	var bottom_left_3d = Vector3(top_left.x, 0, bottom_right.y)
	var bottom_right_3d = Vector3(bottom_right.x, 0, bottom_right.y)
	
	# Top edge
	immediate_mesh.surface_add_vertex(top_left_3d)
	immediate_mesh.surface_add_vertex(top_right_3d)
	
	# Right edge
	immediate_mesh.surface_add_vertex(top_right_3d)
	immediate_mesh.surface_add_vertex(bottom_right_3d)
	
	# Bottom edge
	immediate_mesh.surface_add_vertex(bottom_right_3d)
	immediate_mesh.surface_add_vertex(bottom_left_3d)
	
	# Left edge
	immediate_mesh.surface_add_vertex(bottom_left_3d)
	immediate_mesh.surface_add_vertex(top_left_3d)
	
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
