// Obsbot Meet 2 Full Privacy Cover (Unified Cross-Slot Fix)
$fn = 150;

cam_w = 45.4; 
cam_h = 36.4; 
sleeve_depth = 10.0; 
wall = 1.5;          

lens_dia = 30.0;     
bulge_ext = 6.5;     

module privacy_cover() {
    union() {
        difference() {
            // 1. The main rectangular sleeve
            translate([-(cam_w/2 + wall), -(cam_h/2 + wall), 0]) {
                cube([cam_w + (wall * 2), cam_h + (wall * 2), sleeve_depth + wall]);
            }
            
            // 2. Inner cavity for the camera body
            translate([-cam_w/2, -cam_h/2, 0]) {
                cube([cam_w, cam_h, sleeve_depth + 0.1]);
            }
            
            // 3. Pass-through hole for the lens
            translate([0, 0, sleeve_depth - 0.1]) {
                cylinder(d=lens_dia - (wall * 2), h=wall + 0.2, center=false);
            }
            
            // 4. Halved bottom cutaway for the magnetic mount
            lip_width = 1.0;
            cutout_w = cam_w - (lip_width * 2);
            translate([-cutout_w/2, -(cam_h/2 + wall + 0.1), -0.1]) {
                cube([cutout_w, wall * 1.5, sleeve_depth + wall + 0.2]);
            }
            
            // 5. LED viewing slit in the upper-right front wall
            translate([cam_w/2 - 10, cam_h/2 - 5, sleeve_depth - 0.1]) {
                cube([6, 1.5, wall + 0.2]);
            }
        }
        
        // 6. Outward-extending lens cylinder with closed front & unified top disk slot
        difference() {
            // Outer cylinder body protruding from sleeve front
            translate([0, 0, sleeve_depth + wall]) {
                cylinder(d=lens_dia, h=bulge_ext + wall, center=false);
            }
            
            // Main inner bore (runs from base up to the disk pocket)
            translate([0, 0, sleeve_depth + wall]) {
                cylinder(d=lens_dia - (wall * 2), h=bulge_ext - 1.2, center=false);
            }
            
            // Top disk slot and continuous 10mm wide ear slot
            translate([0, 0, sleeve_depth + wall + bulge_ext - 1.2]) {
                // Circular disk clearance
                cylinder(d=lens_dia - (wall * 2), h=1.2, center=false);
                
                // Single continuous cross-slot spanning fully across the diameter (10mm wide, 1.2mm high)
                translate([0, 0, 0])
                    cube([lens_dia + 2, 10.0, 1.2], center=true);
            }
        }
        
        // 7. Pull tab at the TOP edge
        translate([0, (cam_h/2 + wall + 1), 2]) {
            cube([14, 2, 4], center=true);
        }
    }
}

privacy_cover();