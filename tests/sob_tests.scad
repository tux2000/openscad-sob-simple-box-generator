// Tests of SOB (Sick of Beige) Box generator

// Shows variaous combinations of inner and outer lip plus the bottom face hollow or woth cross member

$fn=32;

// Include the main sob.scad
include <../sob.scad>;

// Overwrite some defaults
SOB_pcb_width = 60;
SOB_pcb_height = 40;
SOB_lip_thickness = 4;


box_height_top = 10;
box_height_bottom = 10;

// Setup a slicer to show our inner geometry
slice_x = 0;
slice_y = 23;
vertoff = 25;

// Top shell lip in
translate([-70,0,0]){
	translate([0,0,vertoff])
	slice(slice_x,slice_y,1){
		sob_box_top(overall_height = box_height_top, lip_type = "inner");
	}
	// Middle shell lip out
	slice(slice_x,slice_y,0){
		sob_box_middle(overall_height = box_height_bottom, lip_type = "outer",  hollow = true);
	}
}

translate([0,0,0]){
	// Top shell lip out
	translate([0,0,vertoff])
	slice(slice_x,slice_y,0){
		sob_box_top(overall_height = box_height_top, lip_type = "outer");	
	}
	// Middle shell lip in
	slice(slice_x,slice_y,0){
		sob_box_middle(overall_height = box_height_bottom, lip_type = "inner");
	}
}

translate([70,0,0]){
	translate([0,0,vertoff])
	slice(slice_x,slice_y,1){
		sob_box_top(overall_height = box_height_top, lip_type = "inner");
	}	
	slice(slice_x,slice_y,0){
		sob_box_middle(overall_height = box_height_bottom, lip_type = "outer", xmember = 0);
	}
}


// Cuts things to show interior
module slice(x=0, y=0, z=0){
	width = SOB_pcb_width+6;
	height = SOB_pcb_height+6;
	depth = box_height_bottom+box_height_top+2;
	if(x >0 || y > 0 || z >0){
		translate([
			  (x > 0)?((width-x)/2):0
			, (y > 0)?-((height-y)/2):0
			, 0
		])
		difference(){
			children();
			translate([x,-y,-5])
			color("red")
			centered_cube([width, height, depth]);
		}
	}else{
		children();
	}
}