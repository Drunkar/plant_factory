use <../openscad_modules/modules/Pipe.scad>;
use <../openscad_modules/modules/PipeCircle.scad>;
use <../openscad_modules/modules/CylinderCircle.scad>;
use <../openscad_modules/modules/ArcOfCylinder.scad>;


module Base(height) {
    difference() {
        union() {
            PipeCircle(
                    num_cylinder=6,
                    r_circle=15,
                    r_pipe_outer=4,
                    r_pipe_inner=3,
                    h_pipe=height
            );
            translate([0, 0, height])
                PipeCircle(
                    num_cylinder=6,
                    r_circle=15,
                    r_pipe_outer=4,
                    r_pipe_inner=1.6,
                    h_pipe=2
            );
        }
        Pipe(r_outer=20, r_inner=15+3, h=height+1);
        Pipe(r_outer=15-3, r_inner=0, h=height+1);
    }

    difference() {
        union() {
            translate([0, 0, height]) {
                Pipe(r_outer=15+3, r_inner=15+1, h=1);

                Pipe(r_outer=15-1, r_inner=15-3, h=1);
            }
        }
        translate([0, 0, height]) {
            CylinderCircle(
                num_cylinder=6,
                r_circle=15,
                r_cylinder=1.6,
                h_cylinder=1
            );
        }
    }
}

module Body(height) {
    translate([0, 0, -2]) {
        CylinderCircle(
            num_cylinder=6,
            r_circle=15,
            r_cylinder=1,
            h_cylinder=2
        );
    }

    difference() {
        CylinderCircle(
                num_cylinder=6,
                r_circle=15,
                r_cylinder=2.6,
                h_cylinder=height+1
        );
        translate([0, 0, height-2])
            CylinderCircle(
                num_cylinder=6,
                r_circle=15,
                r_cylinder=1.6,
                h_cylinder=10
            );
    }

    translate([0, 0, height]) {
        difference() {
            union() {
                Pipe(r_outer=15+3, r_inner=15+0.5, h=1);

                Pipe(r_outer=15-0.5, r_inner=15-3, h=1);
            }

            CylinderCircle(
                num_cylinder=6,
                r_circle=15,
                r_cylinder=1.6,
                h_cylinder=1
            );

            ArcOfCylinder(r_outer=15+3, r_inner=15-3, height=height+1, angle=40);
        }
    }


}

//Base(4);

translate([0, 0, 4+1])
    for ( i = [0 : 0] ) {
        translate([0, 0, i*(10+1)])
            rotate([0, 0, (i+1)*0])
                Body(10);
    }
