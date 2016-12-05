use <./Connector.scad>;


module Columns(num_column=10, column_x=1, column_y=1, column_height=80, length=100) {
    interval = length/num_column;
    for ( i = [0 : num_column] ) {
        translate([interval*i, 0, 0]) {
            cube([column_x, column_y, column_height]);
        }
    }
}

W = 93;
H = 83;
THICKNESS = 4;
// ["normal", "wide"]
TYPE = "normal";

// wall
difference() {
    union() {
        cube([W, H, THICKNESS]);
        if (TYPE == "wide") {
            translate([-THICKNESS, 0, 0])
                cube([THICKNESS, H, THICKNESS]);
            translate([W, 0, 0])
                cube([THICKNESS, H, THICKNESS]);
        }
    }

    // groove
    translate([-THICKNESS+1, H, 0])
        rotate([1.4, 0, 0])
            rotate([90, 0, 0])
                Columns(
                    num_column=30,
                    column_x=1,
                    column_y=2,
                    column_height=H*1.1,
                    length=W+2*THICKNESS
                );
}

translate([0, 2+2, THICKNESS-1])
    rotate([90, 0, 0]) {
        Connector(1.6, 1.6, 2.5+1);
            translate([W, 0, ])
                mirror([1, 0, 0])
                    Connector(1.6, 1.6, 2.5+1);
}
