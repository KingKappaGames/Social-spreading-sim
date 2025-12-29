y = source == noone ? y : source.Y + popupYOff + heightMax * .5;

draw_set_color(#0f0819);
draw_sprite_ext(displaySprite, 0, x, y, width / widthMax, height / heightMax, dsin(current_time * .2) * 3, c_white, 1);

draw_set_color(c_white);