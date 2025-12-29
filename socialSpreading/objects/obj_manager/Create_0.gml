global.managerNodes = id;

#region node creation and managemnt

createNodes = function() {
	global.nodeConnectionsTotalCount = 0;
	
	nodes = array_create(nodeCount);

	for(var _i = 0; _i < nodeCount; _i++) {
		var _x = x + irandom_range(-nodeSpawnRange, nodeSpawnRange) + irandom_range(-nodeSpawnRange, nodeSpawnRange);
		var _y = y + irandom_range(-nodeSpawnRange, nodeSpawnRange) + irandom_range(-nodeSpawnRange, nodeSpawnRange);
		var _node = new node(_x, _y, 1, irandom(E_allegiance.count - 1),, _i);
		
		nodes[_i] = _node;
	}
	
	for(var _i = 0; _i < nodeCount; _i++) {
		nodes[_i].initConnections();
	}
}

function node(xx, yy, spreadStrength, allegianceSet, connectionsArr = undefined, positionInNodeArray = array_get_index(other.nodes, 0)) constructor {
	static addConnection = function(node, connectionStrength, dist = undefined) {
		if(script_connectionGetIndex(self, node) != -1) { // already connected, bail
			exit;
		}
		
		dist ??= point_distance(X, Y, node.X, node.Y);
		array_push(connections, [node, connectionStrength, dist]);
		connectionCount++;
		
		array_push(node.connections, [self, connectionStrength, dist]);
		node.connectionCount++;
		
		global.nodeConnectionsTotalCount++;
	}
	
	static initConnections = function() {
		var _nodes = other.nodes;
		
		var _connectionsMade = 0;
		var _connectionsMadeMax = irandom_range(3, 5);
		
		var _closest = noone;
		var _closestDist = 999999;
		
		for(var _i = 0; _i < nodeCount; _i++) {
			var _connection = _nodes[_i];
			
			if(_connection == self) {
				continue;
			}
			
			var _dist = point_distance(X, Y, _connection.X, _connection.Y);
			
			if(_closestDist > _dist) {
				_closest = _connection;
				_closestDist = _dist;
			}
			
			if(_dist < nodeCertainConnectionDist || (_dist < nodeMaxConnectionDist && random(1) > sqr(_dist / nodeMaxConnectionDist))) {
				_connectionsMade++;
				addConnection(_connection, nodeMinimumConnectionStrength + random(1 - (_dist / nodeMaxConnectionDist)) * (1 - nodeMinimumConnectionStrength), _dist);
				
				if(_connectionsMade >= _connectionsMadeMax) {
					break;
				}
			}
		}
		
		if(_connectionsMade == 0) { // make sure you have at least one connection
			addConnection(_closest, random_range(nodeMinimumConnectionStrength, .5), _closestDist);
		}
	}
	
	///@description Updates all publicity values towards their maximum possible values
	static publicityUpdate = function() {
		var _rumorCount = array_length(rumors);
		for(var _i = 0; _i < _rumorCount; _i++) {
			rumors[_i].publicityUpdate();
		}
	}
	
	static spreadInfo = function(nodeToSpreadTo) {
		var _rumorCount = array_length(rumors);
		var _targetRumors = nodeToSpreadTo.rumors;
		
		for(var _i = 0; _i < _rumorCount; _i++) {
			var _sourceRumor = rumors[_i];
			
			var _sourceKnowledgeMax = _sourceRumor.publicityMax;
			var _targetKnowledgeMax = _targetRumors[_i].publicityMax;
			
			if(_targetKnowledgeMax < _sourceKnowledgeMax) {
				var _sourceKnowledge = _sourceRumor.publicity;
				
				_targetRumors[_i].publicityMax = lerp(_targetKnowledgeMax, _sourceKnowledgeMax, _sourceKnowledge / _sourceKnowledgeMax); // the more the giving city knows total and the more (likely) a given traveler is to know about it, give the target city more potential knowledge (up to the source cities knowledge)
			}
		}
	}
	
	nodeIndexInArray = positionInNodeArray;
	
	X = xx;
	Y = yy;
	
	spread = 1;
	
	color = make_color_rgb(allegianceSet * 174, allegianceSet * 420, allegianceSet * 917);
	size = irandom_range(6, 12);
	
	
	connectionCount = 0;
	
	if(is_undefined(connectionsArr)) {
		connections = [];
	} else {
		connections = []; // node, dist, connectionStrength (eg how good the connection is, regardless of dist, ect)
		
		var _connectionsCount = array_length(connectionsArr);
		var _connection;
		
		for(var _connectI = 0; _connectI < _connectionsCount; _connectI++) {
			_connection = connectionsArr[_connectI];
			addConnection(_connection[0], _connection[1]);
		}
		
		connectionCount = _connectionsCount;
	}
	
	rumors = array_length(E_subjects.count - 1);
	for(var _subjectI = 0; _subjectI < E_subjects.count; _subjectI++) {
		rumors[_subjectI] = new rumor(_subjectI, irandom(E_allegiance.count - 1), 0);
	}
	
	allegiance = allegianceSet;
}

function rumorSet() constructor {
	for(var _i = 0; _i < E_subjects.count; _i++) {
		var _rumor = script_getSubjectString(_i);
		
		struct_set(self, _rumor, new rumor(_i, irandom(E_allegiance.count - 1), 0));
	}
}

function rumor(subjectSet, allegianceType, publicityMaxSet, publicitySpreadFactor = .03, publicityInitial = 0) constructor {
	subject = subjectSet;
	
	publicity = publicityInitial;
	publicityMax = publicityMaxSet;
	publicitySpreadStrength = publicitySpreadFactor; // portion of remaining publicity to fill per update
	
	allegiance = allegianceType;
	
	///@description Adds a portion of the unknown knowledge about this subject to this rumor for this node, eg, if a node knows 50% of a war as it's max and 30% publicity currently, then adding .5 to both would bring peakKnowledge (max) to 75% and the current publicity would rise to 30% + 45% remaining / 2 aka 52.5% to fill half of the remaining potential publicity. Use the set version of this function if you want to force these values!
	static addKnowledge = function(portionOfMaxRemaining = 0, portionOfCurrentRemaining = 0) {
		publicityMax = min(1, lerp(publicityMax, 1, portionOfMaxRemaining));
		publicity = min(1, lerp(publicity, publicityMax, portionOfCurrentRemaining));
	}
	
	///@description Sets the publicity max and current to specific values, out of 1. So .8 and .5 would make the town have 80% of the rumors info within it somewhere and the overall knowledge of the town on average (ish?) 20% of the truth 
	static setKnowledge = function(publicityMaxSet = publicityMax, publicityCurrent = publicity) {
		publicityMax = publicityMaxSet;
		publicity = publicityCurrent;
	}
	
	static publicityUpdate = function() {
		publicity = lerp(publicity, publicityMax, random_range(publicitySpreadStrength * .5, publicitySpreadStrength * 1.2));
	}
}

createNodes();

#endregion

//node data read outs
nodeHovered = noone;
nodeHoveredPrevious = noone;

popup = noone;


mouseInfluenceRange = 500;