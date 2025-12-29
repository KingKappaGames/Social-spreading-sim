/// @desc Function Get the index of the connections array for another node (returns -1 if none or the index of connections array if found)
/// @param {any*} nodeOther 
/// @returns {real} The index or -1 if not connected
function script_connectionGetIndex(nodeFrom, nodeTo) {
	
	var _index = array_find_index(nodeFrom.connections, method({nodeTo}, function(element, index) {
		if(element[0] == nodeTo) {
			return true;
		} else {
			return false;
		}
	})); 
	
	return _index;
}