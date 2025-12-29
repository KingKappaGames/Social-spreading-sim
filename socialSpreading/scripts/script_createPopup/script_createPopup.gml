function script_createPopup(xx, yy, source) {
	var _popup = instance_create_layer(xx, yy + popupYOff, "Instances", obj_textPanel);
	_popup.source = source;
	
	_popup.bakeText();
	
	return _popup;
}