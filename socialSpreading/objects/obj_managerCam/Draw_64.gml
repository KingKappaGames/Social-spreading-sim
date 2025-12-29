
if(debug > 0) {
	if(debug == E_debugMode.lag) {
		draw_text(20, 20, $"fps: {fps}");
		draw_text(20, 50, $"fps_real: {fps_real}");
		draw_text(20, 80, $"mouse: {mouse_x}/{mouse_y}");
		draw_text(20, 110, $"instance count: {instance_number(all)}");
	} else if(debug == E_debugMode.camera) {
		draw_text(20, 20, $"camX: {camera_get_view_x(cam)}");
		draw_text(20, 50, $"camY: {camera_get_view_y(cam)}");
		draw_text(20, 80, $"camWidth: {camera_get_view_width(cam)}");
		draw_text(20, 110, $"camHeight: {camera_get_view_height(cam)}");
	} else if(debug == E_debugMode.nodes) {
		draw_text(20, 20, $"Node count: {array_length(global.managerNodes.nodes)}");
		draw_text(20, 50, $"Node connections (total): {global.nodeConnectionsTotalCount}");
		draw_text(20, 80, $"Spread time scale: {global.gameRate}");
		draw_text(20, 110, $"Mouse impact (subject list, 0-1 power): {global.mouseInfluence}");
	}
}
