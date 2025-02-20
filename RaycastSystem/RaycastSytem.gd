extends Node3D
# Po co to tu jest? A tak się składa, że nie mam pojęcia 
#Co jest zabawne bo sam to napisałem

const RAY_LENGTH := 100

func do_raycast_on_mouse_position(CollisionMask: int =  0b00000000_00000000_00000000_00000001):
	var SpaceState = get_world_3d().direct_space_state
	var Cam = get_viewport().get_camera_3d()
	var MousePos = get_viewport().get_mouse_position()
	
	var origin = Cam.project_ray_origin(MousePos)
	var end = origin + Cam.project_ray_normal(MousePos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	
	var result = SpaceState.intersect_ray(query)
	return result
	
func get_mouse_world_position(CollisionMask: int =  0b00000000_00000000_00000000_00000001):
	var RaycastResult = do_raycast_on_mouse_position(CollisionMask)
	if RaycastResult:
		return RaycastResult.position
	return null
	
func get_raycast_hit_object(CollisionMask: int =  0b00000000_00000000_00000000_00000001):
	var RaycastResult = do_raycast_on_mouse_position(CollisionMask)
	if RaycastResult:
		return RaycastResult.collider
	return null 
