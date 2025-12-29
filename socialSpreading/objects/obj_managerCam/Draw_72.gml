
var _width = camera_get_view_width(cam);
var _height = camera_get_view_height(cam);
draw_sprite_tiled(spr_gridBackground, 0, camera_get_view_x(cam) + _width * .5, camera_get_view_y(cam) + _height * .5);