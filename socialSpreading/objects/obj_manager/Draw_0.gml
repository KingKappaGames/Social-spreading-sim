for(var _i = 0; _i < nodeCount; _i++) {
	var _node = nodes[_i];
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	
	with(_node) {
		for(var _connectionI = 0; _connectionI < connectionCount; _connectionI++) {
			var _connectionInfo = connections[_connectionI];
			
			var _connection = _connectionInfo[0];
			
			if(_connection.nodeIndexInArray > nodeIndexInArray) { // only draw if lower on the chain (this will give all nodes only one link per node-node connection and make all connections under node body)
				var _strength = _connectionInfo[1];
				
				draw_line_width_color(X, Y, _connection.X, _connection.Y, _connectionInfo[1] * 5 + 4.5, nodeConnectionOutlineColor, nodeConnectionOutlineColor);
				draw_line_width_color(X, Y, _connection.X, _connection.Y, _connectionInfo[1] * 5 + 3, color, _connection.color);
			}
		}
		
		//nodeRumorLengthBase
		var _rumorsCount = array_length(rumors);
		var _dir = X * 7 + Y * 137;
		var _baseDist = size + nodeRumorLengthBase;
		var _length, _publicityMaxLength, _color;
		for(var _subjectI = 0; _subjectI < _rumorsCount; _subjectI++) {
			_length = _baseDist + rumors[_subjectI].publicity * nodeRumorLengthScale;
			_publicityMaxLength = _baseDist + rumors[_subjectI].publicityMax * nodeRumorLengthScale;
			_color = global.subjectCol[_subjectI];
			
			draw_line_width_color(X, Y, X + lengthdir_x(_publicityMaxLength, _dir), Y + lengthdir_y(_publicityMaxLength, _dir), nodeRumorWidth, c_white, c_white);
			draw_line_width_color(X, Y, X + lengthdir_x(_length, _dir), Y + lengthdir_y(_length, _dir), nodeRumorWidth, _color, _color);
			
			_dir += 360 / _rumorsCount;
		}
				
		draw_circle(X, Y, size + nodeRumorLengthBase, true);
		
		draw_circle_color(X, Y, size + 1, nodeConnectionOutlineColor, nodeConnectionOutlineColor, false);
		draw_circle_color(X, Y, size, color, color, false);
	}
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_center);
}

draw_circle(mouse_x, mouse_y, mouseInfluenceRange, true);