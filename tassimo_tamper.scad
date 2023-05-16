/*
Coffee tamper for reuable coffee pods
2023 Adam Mead
https://www.printables.com/@AdamMead_323502/models
https://github.com/amead77
*/

//leave this as 1
runlevel = 1;
//resolution of the model, 100 is good for printing, 10 is good for viewing
$fn = 100;
//diameter of the tamper
outer_dia = 50.5; 
//diameter of the inner circle to remove from the tamper (flow hole)
remove_edge_dia = 19.0; 
//shouldn't need to adjust this, it's the thickness of the edge of the tamper that is removed
remove_edge_thickness = 15.0;
//offset from the edge of the tamper to the smaller inlet hole (it appears to be 55mm)
remove_edge_offset = 4.5; 

//base part of the tamper thickness, before the cone starts
tamper_thickness = 5.0;
//diameter of the stem of the tamper
stem_dia = 10.0;
//as measured from the top of the tamper base (bottom of cone) to the center of the sphere on top
stem_length = 30.0;
ball_dia = 20.0;
tamper_cone_length = 10.0;

//is a central depression required in the tamper (for people who don't fill the pod to the top)
tamper_center_depression = false;
tamper_center_depression_width = 19.0;
tamper_center_depression_depth = 2.0;

//chamfer on the base of the tamper
base_chamfer = 1.0; 

module tamper_base() {
    // Create the tamper
    cylinder(h = tamper_thickness, d = outer_dia, center = true);
}

module tamper_stem() {
    //stem joins to top of base
    translate([0, 0, tamper_thickness/2]) 
        cylinder(h = stem_length, d = stem_dia, center = false);
}

module tamper_ball() {
    //sphere sits on top of stem
    translate([0, 0, tamper_thickness + stem_length])
        sphere(d = ball_dia);
}

module tamper_cone() {
    //cone joins to bottom of base
    translate([0, 0, tamper_thickness/2])
        cylinder(h = tamper_cone_length, d1 = outer_dia, d2 = stem_dia, center = false);
}

module remove_edge() {
    //remove the edge of the tamper
    translate([(outer_dia/2)+(remove_edge_offset/2), 0, -tamper_thickness/2])
        cylinder(h = remove_edge_thickness, d = remove_edge_dia, center = false);
}

module remove_chamfer() {
    //remove the chamfer from the tamper
    
    translate([0, 0, -tamper_thickness/2])
        difference() {
            cylinder(h = base_chamfer, d = outer_dia, center = true);
            cylinder(h = base_chamfer, d1 = outer_dia-base_chamfer, d2 = outer_dia, center = true);
        }
}

module remove_center_depression() {
    //remove the center depression from the tamper
    translate([0, 0, -tamper_thickness/2])
        cylinder(h = tamper_center_depression_depth, d = tamper_center_depression_width, center = true);
}

if (runlevel == 1) {
    render() {
        difference() {
            union() {
                tamper_base();
                tamper_stem();
                tamper_ball();
                tamper_cone();
            }
            remove_edge();
            remove_chamfer();
            if (tamper_center_depression == true) {
                remove_center_depression();
            }
        }
    }
}   
if (runlevel == 2) {
    render() {
        remove_chamfer();
    }
}