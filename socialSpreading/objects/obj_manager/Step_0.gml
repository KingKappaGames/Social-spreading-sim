global.timer++;

if(keyboard_check_released(ord("C"))) {
	createNodes();
}

if(global.timer % 10 == 0) {
	nodeHoveredPrevious = nodeHovered;
	
	var _found = noone;
	
	for(var _i = 0; _i < nodeCount; _i++) {
		var _node = nodes[_i]; 
		
		with(_node) {
			var _dist = point_distance(mouse_x, mouse_y, X, Y);
			
			if(_dist < size + nodeHoverRadiusBuffer) {
				if(!instance_exists(other.popup)) {
					other.popup = script_createPopup(X, Y, self);
				}
				
				_found = self;
				break;
			}
		}
	}
	
	nodeHovered = _found;
	
	if(nodeHovered != nodeHoveredPrevious) {
		if(instance_exists(popup)) {
			popup.source = _found;
			
			if(_found != noone) {
				popup.reset();
			}
		}
	} else {
		if(instance_exists(popup)) {
			if(popup.source != noone) {
				popup.bakeText();
			}
		}
	}
}

if(mouse_check_button_released(mb_left)) { 
	var _subject = irandom(E_subjects.count - 1);
	
	for(var _i = 0; _i < nodeCount; _i++) {
		var _node = nodes[_i];
		
		var _dist = point_distance(mouse_x, mouse_y, _node.X, _node.Y);
		
		if(_dist <= mouseInfluenceRange) { 
			for(var _addI = 0; _addI < E_subjects.count; _addI++) {
				_node.rumors[_addI].addKnowledge(global.mouseInfluence[_addI], 0);
			}
		}
	}
}

//RANDOMLY TICK UP AWARENESS OF PULIC IN NODES TOWARDS POTENTIAL KNOWLEDGE BASE VALUE (eg, if knowledge DOES exist in a city (max is high) then it will slowly disseminate to general public (current)
repeat(global.gameRate) {
	if(random(1) < .1) {
		repeat(5) {
			var _nodeToTick = irandom(nodeCount - 1);
			nodes[_nodeToTick].publicityUpdate();
		}
		
		repeat(1) {
			var _nodeToTick = irandom(nodeCount - 1);
			var _node = nodes[_nodeToTick];
			
			var _target = _node.connections[irandom(_node.connectionCount - 1)];
			
			_node.spreadInfo(_target[0]);
		}
	}
}

if(keyboard_check_released(vk_down)) {
	global.gameRate = round(max(1, global.gameRate * .9 - 1));
}

if(keyboard_check_released(vk_up)) {
	global.gameRate = round(global.gameRate * 1.1 + 1);
}

var _influence = .01;
if(keyboard_check(ord("0"))) {
	global.mouseInfluence[0] = (global.mouseInfluence[0] + _influence) % 1;
}
if(keyboard_check(ord("1"))) {
	global.mouseInfluence[1] = (global.mouseInfluence[1] + _influence) % 1;
}
if(keyboard_check(ord("2"))) {
	global.mouseInfluence[2] = (global.mouseInfluence[2] + _influence) % 1;
}
if(keyboard_check(ord("3"))) {
	global.mouseInfluence[3] = (global.mouseInfluence[3] + _influence) % 1;
}

if(keyboard_check(ord("4"))) {
	global.mouseInfluence[4] = (global.mouseInfluence[4] + _influence) % 1;
}