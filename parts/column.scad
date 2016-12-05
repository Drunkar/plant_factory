use <../openscad_modules/modules/ExtendablePipe.scad>;

Y = 93;
H = 100;

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
/*translate([6, Y - 8, 0])
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
    );*/

translate([5, 10, 90+10])
    rotate([0, 90, 0]) {
        difference() {
            cube([55, 10, 2]);

            translate([-20, -5, 0])
            for (i=[0: 7]) {
                for (j=[0:12]) {
                    translate([4.5*j+i*2, 4*i, 0])
                        rotate([0, 0, 90])
                            cylinder(r=2, h=5, $fn=6);
                }
            }
            translate([57, 5, 0])
                cylinder(r=5, h=2);

            // columns
            rotate([0, -90, 0])
                translate([-5, -10, -(90+10)]) {
                    translate([6, 8, 0])
                        cylinder(r=3.8, h=H);
                    translate([6, 22, 0])
                        cylinder(r=3.8, h=H);
            }
        }
    }
