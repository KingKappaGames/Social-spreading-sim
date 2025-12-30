#region DEBUG DRAWING FOR DEBUGGER - helps see the results of allegaince grid at each step (used with debugger, uncomment to make work)
gridSurf = surface_create(1000, 1000); // what is this surface stuff for? I'll tell you, it's a pain to debug visual grids in code without having a way to break the code up, but we can make use of debugger graphics to fix that, (UNCOMMENT THIS CODE FIRST, the drawGridSurf and surface init, plus the draw grid you want to tag) so put a break point AFTER the draw surf that comes after the point you want to check the grid at, then go to graphics and look at the surface it's generated, it will show you the grid of all allegiances at that point. Very cool.

drawGridSurf = function() {
	surface_set_target(gridSurf);
	
	draw_clear_alpha(c_black, 1);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	var _step = 1000 / E_allegiance.count;
	var _textScale = 3.5;
	
	for(var _i = 0; _i < E_allegiance.count; _i++) {
		for(var _j = 0; _j < E_allegiance.count; _j++) {
			draw_text_transformed(_i * _step + _step * .5, _j * _step + _step * .5, global.allegianceGrid[# _i, _j], _textScale, _textScale, 0);
		}
	}
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	surface_reset_target();
}

#endregion

enum E_allegiance {
	royal,
	bandit,
	common,
	wild,
	neutral,
	fightAll,
	fightAllExceptSelf,
	count
}

/// @desc With these functions you can set the opinion for one allegiance of another, source being the "viewers" and target being the "viewed"
/// @param {real} source The "viewers", these people will see the targets with this opinion
/// @param {real} target The "viewed" group, these people will produce the opinion of them in the viewer, does that make sense..?
/// @param {any*} opinion The opinion value for this source to have of the target (recommened to stick to range of  0-1  however any value is valid, just depends on your prefered ranges for intensity)
/// @param {bool} [mirror]=true Whether the opinion should be mirrored such that the source's opinion of the target is also the target's opinion of the source. Default is TRUE, for simplicities sake. Otherwise set to false and set both the source>target and target>source separately.
function script_setAllegianceRelationship(source, target, opinion, mirror = true) {
	ds_grid_set(global.allegianceGrid, source, target, opinion);
	
	if(mirror) {
		ds_grid_set(global.allegianceGrid, target, source, opinion);
	}
}

/// @desc Gets the opinion of the source faction to the target faction
/// @param {real} source The observing faction
/// @param {real} target The viewed faction
function script_getAllegianceRelationship(source, target) {
	gml_pragma("forceinline");
	return ds_grid_get(global.allegianceGrid, source, target);
}

#region Allegiance system init
global.allegianceGrid = ds_grid_create(E_allegiance.count, E_allegiance.count); // each faction x each faction, gives the result of each combination
var _grid = global.allegianceGrid;

for(var _x = 0; _x < E_allegiance.count; _x++) {
	for(var _y = 0; _y < E_allegiance.count; _y++) {
		_grid[# _x, _y] = -1; // unset fill in value (blank canvas)
	}
}

for(var _fightEveryoneI = 0; _fightEveryoneI < E_allegiance.count; _fightEveryoneI++) {
	ds_grid_set(_grid, E_allegiance.fightAll, _fightEveryoneI, 0); // they fight everyone bro
}

for(var _fightOthersI = 0; _fightOthersI < E_allegiance.count; _fightOthersI++) {
	if(_fightOthersI == E_allegiance.fightAllExceptSelf) {
		ds_grid_set(_grid, E_allegiance.fightAllExceptSelf, _fightOthersI, 1); // except themselves..
	} else {
		ds_grid_set(_grid, E_allegiance.fightAllExceptSelf, _fightOthersI, 0); // they fight everyone bro*
	}
}

for(var _neutralI = 0; _neutralI < E_allegiance.count; _neutralI++) {
	if(_neutralI != E_allegiance.fightAll && _neutralI != E_allegiance.fightAllExceptSelf) { // don't set neutrality to people that always hate you..
		ds_grid_set(_grid, E_allegiance.neutral, _neutralI, 1); // "likes" everyone, and vice versa
	}
}

//drawGridSurf();

var _filledPositions = [];
var _filledCount = 0;
var _fillValue;
for(var _x = 0; _x < E_allegiance.count; _x++) {
	for(var _y = 0; _y < E_allegiance.count; _y++) {
		_fillValue = _grid[# _x, _y];
		if(_fillValue != -1) {
			_filledPositions[_filledCount] = [_x, _y, _fillValue]; // gather up all given relationships so that in the next step you can flip them so that a-b is b-a (not technically a guarenteed assumption, to be fair, but usually true. You may of course sometimes have places where one group sees the other poorly and they see them well, a non mirrored opinion, if you see what I'm saying)
			_filledCount++;
		}
	}
}

var _fillData;
for(var _mirrorI = 0; _mirrorI < _filledCount; _mirrorI++) {
	_fillData = _filledPositions[_mirrorI];
	_grid[# _fillData[1], _fillData[0]] = _fillData[2]; // flip filled values to mirror (eg barbarians hate knight SO knights hate barbarians, 1,3 = 3,1)
}

for(var _sameToSameI = 0; _sameToSameI < E_allegiance.count; _sameToSameI++) {
	if(_sameToSameI != E_allegiance.fightAll) {
		_grid[# _sameToSameI, _sameToSameI] = 1; // reflexive views should always be positive, aka, no in fighting... Although... I suppose a type of person that fights others of its kind is possible.. for now nah though
	}
}

#endregion

//drawGridSurf();

// I strongly recommend a cascading system, where the first allegiance gets relations to all further allegiances, then the 2nd one gets relations to all further (so excluding the first, that was set already), then the 3rd gets all further (excluding 1st and 2nd), ect, this lets you see and insert new things easily and understand the shape of your relations without having to pick them out in a pile of 50 relationship sets

script_setAllegianceRelationship(E_allegiance.royal, E_allegiance.bandit, .2);
script_setAllegianceRelationship(E_allegiance.royal, E_allegiance.common, .7);
script_setAllegianceRelationship(E_allegiance.royal, E_allegiance.wild, .4);

script_setAllegianceRelationship(E_allegiance.bandit, E_allegiance.common, .3);
script_setAllegianceRelationship(E_allegiance.bandit, E_allegiance.wild, .5);

script_setAllegianceRelationship(E_allegiance.common, E_allegiance.wild, .65);

//drawGridSurf();

//var _dog = "hi"; // yeah gonna be honest this isn't supposed to be here, but i can't jump to a break point at the end of the file soooooo, placeholder thing here (if using the grid drawing debug, this helps catch the break point)