use <../openscad_modules/modules/ExtendablePipe.scad>;
use <../openscad_modules/modules/TrussBeamTwoDimensions.scad>;
use <../openscad_modules/modules/HoneyCombPlate.scad>;
use <../openscad_modules/modules/ArcOfCylinder.scad>;

Y = 93;
H = 18 + 10;
truss_length = 81;
truss_thickness = 2;
honeycomb_height = 10;

translate([6, 8, 0])
    ExtendablePipe(
        h=H,
        h_joint=5,
        r_outer=4.5,
        r_inner=3,
        num_groove=10,
        depth_of_groove=0.5,
        width_of_groove=0.5
    );
translate([6, 22, 0])
    ExtendablePipe(
        h=H,
        h_joint=5,
        r_outer=4.5,
        r_inner=3,
        num_groove=10,
        depth_of_groove=0.5,
        width_of_groove=0.5
    );
translate([6, Y - 8, 0])
    ExtendablePipe(
        h=H,
        h_joint=5,
        r_outer=4.5,
        r_inner=3,
        num_groove=10,
        depth_of_groove=0.5,
        width_of_groove=0.5
    );
translate([6, Y - 22, 0])
    ExtendablePipe(
        h=H,
        h_joint=5,
        r_outer=4.5,
        r_inner=3,
        num_groove=10,
        depth_of_groove=0.5,
        width_of_groove=0.5
    );

// truss
translate([0, 0, 9.5])
    rotate([90, 0, 0]) {
        translate([10, 0, -(8+1)]) {
            TrussBeamTwoDimensions(
                x=truss_length,
                y=10,
                thickness=truss_thickness,
                rod_height=2,
                truss_width=2,
                truss_angle=45
            );

            // tensile
            translate([truss_length, 10-1, 0])
                rotate([0, 0, 85])
                   cube([1, 82, 2]);
        }

        translate([10, 0, -(22+1)]) {
            TrussBeamTwoDimensions(
                x=truss_length,
                y=10,
                thickness=truss_thickness,
                rod_height=2,
                truss_width=2,
                truss_angle=45
            );

            // tensile
            translate([truss_length, 10-1, 0])
                rotate([0, 0, 85])
                   cube([1, 82, 2]);
        }
        translate([10, 0, -(Y-8+1)]) {
            TrussBeamTwoDimensions(
                x=truss_length,
                y=10,
                thickness=truss_thickness,
                rod_height=2,
                truss_width=2,
                truss_angle=45
            );

            // tensile
            translate([truss_length, 10-1, 0])
                rotate([0, 0, 85])
                   cube([1, 82, 2]);
        }
        translate([10, 0, -(Y-22+1)]) {
            TrussBeamTwoDimensions(
                x=truss_length,
                y=10,
                thickness=truss_thickness,
                rod_height=2,
                truss_width=2,
                truss_angle=45
            );

            // tensile
            translate([truss_length, 10-1, 0])
                rotate([0, 0, 85])
                   cube([1, 82, 2]);
        }
}

// ハニカムを吊って横軸を通す
translate([16+2, 6+truss_thickness, 11.5-9.5]) {
    HoneyCombPlate(
        x=truss_length-12,
        y=18-2*truss_thickness,
        thickness=1.5,
        padding=0,
        r_honeycomb=3,
        margin_honeycomb=0.2
    );
}
translate([16+2, Y - (6+truss_thickness+(18-2*truss_thickness)), 11.5-9.5]) {
    HoneyCombPlate(
        x=truss_length-12,
        y=18-2*truss_thickness,
        thickness=1.5,
        padding=0,
        r_honeycomb=3,
        margin_honeycomb=0.2
    );
}

module KnifePlate(x, y, z) {
    difference() {
        cube([x, y, z]);
        translate([0.5, 0, 0])
            rotate([0, 45, 0])
                cube([x, y, z]);
    }
}

for ( i = [0 : 5] ) {
    translate([16+i*14, 0, 8-honeycomb_height+2]) {
        KnifePlate(2, 93, 11.5);
    }
}

// arch
translate([6, Y/2, -50+26])
    rotate([0, 90, 0])
        ArcOfCylinder(r_outer=50, r_inner=48, height=1, angle=50);
