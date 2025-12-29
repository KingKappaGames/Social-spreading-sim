depth -= 1;

source = noone;

buttonData = noone;

displaySprite = -1;

width = 0;
height = 0;

widthMax = 1200;
heightMax = 0;

lerpRateOpen = .24;
lerpRateClose = .29;

reset = function() {
	width = 0;
	height = 0;
}

textScale = .7;
textBoxMargin = 50;
lineHeight = 64;

textAreaWidth = widthMax - textBoxMargin * 2;

bakeText = function() {
	draw_set_font(fnt_fontScale2);
	
	var _scale = textScale;
	var _extraSpaceForOtherInfo = 0;
	
	var _text = "";
	
	for(var _subjectI = 0; _subjectI < E_subjects.count; _subjectI++) {
		var _sourceRumor = source.rumors[_subjectI];
		_text += script_getAwarenessReport(_subjectI, _sourceRumor);
		_text += "\n\n";
	}
	
	heightMax = string_height_ext(_text, lineHeight, textAreaWidth / _scale) * _scale + textBoxMargin + _extraSpaceForOtherInfo;
	
	var _surf = surface_create(widthMax, heightMax);
	
	var _tipW = sprite_get_width(spr_buttonFrameMax);
	var _tipH = sprite_get_height(spr_buttonFrameMax);
	
	surface_set_target(_surf);
	draw_sprite_ext(spr_buttonFrameMax, 0, 0, 0, widthMax / _tipW, heightMax / _tipH, 0, c_white, 1);
	
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	draw_text_ext_transformed(widthMax * .5, heightMax * .06, _text, lineHeight, textAreaWidth / _scale, _scale, _scale, 0);

	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	surface_reset_target();
	
	
	if(sprite_exists(displaySprite)) {
		sprite_delete(displaySprite);
	}
	
	displaySprite = sprite_create_from_surface(_surf, 0, 0, widthMax, heightMax, false, false, widthMax * .5, heightMax * .5);
	
	draw_set_font(-1);
}