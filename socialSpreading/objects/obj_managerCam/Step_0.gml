
#region manager stuff
	if(keyboard_check_released(vk_control)) {
		debug = (debug + 1) % E_debugMode.debugModeCount;
	}
	
	#region camera stuff
	
	if(keyboard_check_released(ord("F"))) {
		window_set_fullscreen(!window_get_fullscreen());
	}

	if(keyboard_check_released(vk_escape)) {
		game_end();
	}
	
	var _camX = camera_get_view_x(cam);
	var _camY = camera_get_view_y(cam);
	var _camW = camera_get_view_width(cam);
	var _camH = camera_get_view_height(cam);
	
	var _camChange = (keyboard_check(vk_subtract) - keyboard_check(vk_add) + mouse_wheel_down() * camScrollZoomSpeed - mouse_wheel_up() * camScrollZoomSpeed) * camZoomSpeed;
	if(_camChange != 0) {
		global.camSize = clamp(global.camSize * (1 + _camChange), camZoomMin, camZoomMax);
		camera_set_view_size(cam, global.camSize * camWidthBase, global.camSize * camHeightBase);
		camera_set_view_pos(cam, clamp(_camX - (camera_get_view_width(cam) - _camW) * .5, camMinX, camMaxX - camera_get_view_width(cam)), clamp(_camY - (camera_get_view_height(cam) - _camH) * .5, camMinY, camMaxY - camera_get_view_height(cam)));
	}
	
	if(mouse_check_button(mb_middle)) {
		camera_set_view_pos(cam, clamp(_camX - (mouse_x - global.mouseXPrevious) * camDragSpeedMult, camMinX, camMaxX - camera_get_view_width(cam)), clamp(_camY - (mouse_y - global.mouseYPrevious) * camDragSpeedMult, camMinY, camMaxY - camera_get_view_height(cam)));
	}
	
	#endregion
#endregion