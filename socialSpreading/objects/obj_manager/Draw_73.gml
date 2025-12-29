if(global.managerCam.debug == E_debugMode.nodes) {
	for(var _i = 0; _i < nodeCount; _i++) {
		var _node = nodes[_i];
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		
		with(_node) {
			draw_text(X, Y - size * 2, connectionCount);
			draw_text(X, Y - size - 40, nodeIndexInArray);
		}
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_center);
	}
}