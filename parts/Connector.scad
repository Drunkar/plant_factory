module Connector(width, height, depth) {
    for ( i = [0 : 2] ) {
        translate([10 + (2+2)*i+(2.4-width)/2, 0, 0])
            cube([width, depth, height]);
    }
}