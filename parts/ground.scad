use <../openscad_modules/modules/CoverForBox.scad>;
use <../openscad_modules/modules/ExtendablePipe.scad>;
use <../openscad_modules/modules/CylinderCircle.scad>;
use <./Connector.scad>;

// parameters for box covered by this module
X = 93;
Y = 93;
PLATE_THICKNESS = 4;
// ["male", "female"]
TYPE = "male";


module PlantHoles(x, y, x_offset, y_offset, thickness, male) {
    difference() {
        union() {
            cube([x, y, thickness]);
            translate([x_offset, y_offset, -2])
                cube([x - 2 * x_offset, y - 2 * y_offset, 2]);
        }

        // サイフォンホース用に9mmの穴
        translate([51, 4+4, -2]) {
            cylinder(r=4.5, h=thickness + 2);
            translate([-4.5, -4.5-4, 0])
                cube([9, 9, thickness + 2]);
        }
        translate([51, y - (4+4), -2]) {
            cylinder(r=4.5, h=thickness + 2);
            translate([-4.5, 0, 0])
                cube([9, 9, thickness + 2]);
        }

        // plant holes
        translate([30, 28, -2]) {
            cylinder(r=11, h=thickness + 2);
            %cylinder(r=18, h=10 + 2);
        }
        translate([71, 21, -2]) {
            cylinder(r=11, h=thickness + 2);
            %cylinder(r=18, h=10 + 2);
        }
        translate([30, y - 19, -2]) {
            cylinder(r=11, h=thickness + 2);
            %cylinder(r=18, h=10 + 2);
        }
        translate([x - 21, y - 28, -2]) {
            cylinder(r=11, h=thickness + 2);
            %cylinder(r=18, h=10 + 2);
        }

        // connectors
        if (male != 1) {

            Connector(2.6, 2.6, y_offset);
            translate([x, 0, 0])
                mirror([1, 0, 0])
                    Connector(2.6, 2.6, y_offset);

            translate([0, y, 0])
                mirror([0, 1, 0]) {
                    Connector(2.4, 2, y_offset);
                    translate([x, 0, 0])
                        mirror([1, 0, 0])
                            Connector(2.6, 2.6, y_offset);
                }

            translate([x, 0, 0])
                rotate([0, 0, 90]) {
                    Connector(2.46, 2.6, x_offset);
                        translate([x, 0, 0])
                            mirror([1, 0, 0])
                                Connector(2.6, 2.6, x_offset);

                        translate([0, y, 0])
                            mirror([0, 1, 0]) {
                                Connector(2.6, 2.6, x_offset);
                                translate([x, 0, 0])
                                    mirror([1, 0, 0])
                                        Connector(2.6, 2.6, x_offset);
                            }
                }
        } // if

        // extension mounters
        mounter_depth = 3;
        translate([0, 0, thickness-mounter_depth]) {
            translate([30, 28, 0]) {
                CylinderCircle(
                    num_cylinder=6,
                    r_circle=15,
                    r_cylinder=2,
                    h_cylinder=mounter_depth
                );
            }
            translate([71, 21, 0]) {
                CylinderCircle(
                    num_cylinder=6,
                    r_circle=15,
                    r_cylinder=2,
                    h_cylinder=mounter_depth
                );
            }
            translate([30, y - 19, 0]) {
                    CylinderCircle(
                    num_cylinder=6,
                    r_circle=15,
                    r_cylinder=2,
                    h_cylinder=mounter_depth
                );
            }
            translate([x - 21, y - 28, 0]) {
                    CylinderCircle(
                    num_cylinder=6,
                    r_circle=15,
                    r_cylinder=2,
                    h_cylinder=mounter_depth
                );
            }
        }
    } // difference


    // connectors
    if (male == 1) {
        translate([0, -(y_offset-0.5), 0])
            Connector(1.6, 1.6, y_offset-0.5);
        translate([x, 0, 0])
            mirror([1, 0, 0])
                translate([0, -(y_offset-0.5), 0])
                    Connector(1.6, 1.6, y_offset-0.5);

            translate([0, y, 0])
                mirror([0, 1, 0]) {
                    translate([0, -(y_offset-0.5), 0])
                        Connector(1.6, 1.6, y_offset-0.5);
                    translate([x, 0, 0])
                        mirror([1, 0, 0])
                            translate([0, -(y_offset-0.5), 0])
                                Connector(1.6, 1.6, y_offset-0.5);
                }

            translate([x, 0, 0])
                rotate([0, 0, 90]) {
                    translate([0, -(y_offset-0.5), 0])
                        Connector(1.6, 1.6, x_offset-0.5);
                    translate([x, 0, 0])
                        mirror([1, 0, 0])
                            translate([0, -(y_offset-0.5), 0])
                                Connector(1.6, 1.6, x_offset-0.5);

                        translate([0, y, 0])
                            mirror([0, 1, 0]) {
                                translate([0, -(y_offset-0.5), 0])
                                    Connector(1.6, 1.6, x_offset-0.5);
                                translate([x, 0, 0])
                                    mirror([1, 0, 0])
                                        translate([0, -(y_offset-0.5), 0])
                                            Connector(1.6, 1.6, x_offset-0.5);
                            }
                }
    }
}


// main
// top plate
if (TYPE == "male") {
    PlantHoles(X, Y, 3, 3, PLATE_THICKNESS, male=1);
} else {
    PlantHoles(X, Y, 3, 3, PLATE_THICKNESS, male=0);
}

// columns
translate([6, 8, 0])
    ExtendablePipe(
        h=4,
        h_joint=4,
        r_outer=4,
        r_inner=3,
        num_groove=10,
        depth_of_groove=0.5,
        width_of_groove=0.5
    );
translate([6, 22, 0])
    ExtendablePipe(
        h=4,
        h_joint=4,
        r_outer=4,
        r_inner=3,
        num_groove=10,
        depth_of_groove=0.5,
        width_of_groove=0.5
    );
translate([6, Y - 8, 0])
    ExtendablePipe(
        h=4,
        h_joint=4,
        r_outer=4,
        r_inner=3,
        num_groove=10,
        depth_of_groove=0.5,
        width_of_groove=0.5
    );
translate([6, Y - 22, 0])
    ExtendablePipe(
        h=4,
        h_joint=4,
        r_outer=4,
        r_inner=3,
        num_groove=10,
        depth_of_groove=0.5,
        width_of_groove=0.5
    );
