randomize();

global.managerCam = id;

depth = 5000;

//draw_set_font(fnt_general);

#region camera stuff

view_enabled = true;

camIndex = 0;

view_set_visible(camIndex, true);

global.camSize = 1;
camZoomMin = .02;
camZoomMax = 6;
camWidthBase = 2560;
camHeightBase = 1440;

camZoomSpeed = .015;
camScrollZoomSpeed = 7.5;

renderResWidth = 2560;
renderResHeight = 1440;

view_wport[camIndex] = renderResWidth;
view_hport[camIndex] = renderResHeight; // render resolution

surface_resize(application_surface, renderResWidth, renderResHeight);

cam = view_camera[camIndex];
camMinX = -infinity;
camMinY = -infinity; // with cam sizes built in, eg set this to the actual right bound of the view space, not the camera x/y bound
camMaxX = infinity;
camMaxY = infinity;

camera_set_view_size(cam, global.camSize * camWidthBase, global.camSize * camHeightBase);

camDragSpeedMult= 1;

global.mouseXPrevious = mouse_x;
global.mouseYPrevious = mouse_y;

#endregion

#region debug

debug = 0;

enum E_debugMode {
	none = 0,
	lag,
	camera,
	nodes,
	debugModeCount // auto updates to last position
}

#endregion