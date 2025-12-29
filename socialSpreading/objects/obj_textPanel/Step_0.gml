if(source != noone) {
	width = lerp(width, widthMax, lerpRateOpen);
	height = lerp(height, heightMax, lerpRateOpen);
} else {
	width = lerp(width, 0, lerpRateClose);
	height = lerp(height, 0, lerpRateClose);
	
	if(width < 8) {
		instance_destroy();
	}
}