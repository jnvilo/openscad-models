// gears.scad
// library for parametric involute gears 
// Author: Rudolf Huttary, Berlin 
// last update: June 2016

/*
Found at https://www.thingiverse.com/thing:636119
This remix is at https://www.thingiverse.com/thing:5285589
======================================================================
Update: Februay 2022 by Alex Matulich
Added parameter rack_id to all modules and functions, to specify different toothed racks. The purpose was to design some smooth teeth suitable for 3D printing, including asymmetrical rounded teeth optimized for one-way movement. The possible rack_id values are:
rack_id = 0: Default 20° trapezoid teeth with sharp corners
rack_id = 1: Trapezoid teeth with one perpendicular side, slightly rounded (sawtooth-like)
rack_id = 2: Sinewave teeth
rack_id = 3: Tilted sinewave teeth (approximates a sawtooth)
rack_id = 4: Semicircle teeth (smooth and round, great for 3D printing low-stress gears)
rack_id = 5: (March 2022 update) Cycloid teeth (maximized rolling surfaces)

For teeth without sharp corners, the 'iterations' default value of 150 can be reduced. 120 is a good value for rack_id 1, 2, and 3, and for rack_id=4, iterations can be as low as 75.
======================================================================
*/
iterations = 120; // increase for enhanced resolution beware: large numbers will take lots of time!


verbose = true;   // set to false if no console output is desired

//gear(rack_id=5);

module demo1() { // show all rack styles
    for (rack=[0:5]) let(a=rack<5?rack*360/5:0)
        rotate([0,0,a+90]) translate([rack<5?12.5:0,0,0])
            difference() {
                color("cyan") gear(rack_id=rack);
                color("red") translate([0,0,1]) rotate([0,0,-a-90]) linear_extrude(2, convexity=6) text(str(rack), size=4, halign="center", valign="center");
            }
}
//demo2();
module demo2() { // animation demo
    let (rack=5) {
        translate([$t*36*PI/180*10-8*PI+0.02,0,0])
            color("silver") linear_extrude(1) Rack(m=2, rack_id=rack, clearance=-0.1);
        rotate([0,0,-$t*36]) linear_extrude(1) gear2D(m=2, z=10, rack_id=rack, clearance=0);
    }
}

// help();  // display module prototypes
// default values
// z = 10; // teeth - beware: large numbers may take lots of time!
// m = 1;  // modulus
// x = 0;  // profile shift
// h = 4;  // face_width	respectively axial height
// w = 20; // profile angle
// clearance  // assymmetry of tool to clear tooth head and foot
//    = 0.1; // for external splines
//    = -.1  // for internal splines
// rack_id = 0; // type of gear teeth (see introductory comments)
// w_bevel = 45; // axial pitch angle
// w_helix = 45; // radial pitch angle 

// use this prototype:
// gear(m = modulus, z = Z, x = profile_shift, w = alpha, h = face_width);

//gear(m = modulus, z = Z, x = profile_shift, w = alpha, h = face_width);


module motor_gear(){
    difference(){
    gear_bevel(z=12, m=1, x=0.5); 
    cylinder(100,1.2,$fn=32,center=true);
    }
}

module motor_gear_big(){
    difference(){
    gear_bevel(z=24, m=1, x=0.5,h=5); 
    cylinder(100,2.8,$fn=32,center=true);
    }
}

//motor_gear_big();

motor_gear();
motor_gear_big();
//====  external splines with default values ===

// gear(rack_id=2);
// gear_helix(); 
// gear_herringbone(); 
// gear_bevel(); 

//====  internal splines with default values ===
// Gear();  
// Gear_helix(); 
// Gear_herringbone(); 
// Gear_bevel(); 
// 


//====  internal splines - usage and more examples ===
// gear(z = 25, m = 1, x = -.5, h = 4); 
// gear_bevel(z = 26, m = 1, x = .5, h = 3, w_bevel = 45, w_helix = -45); 
// gear_helix(z = 16, m = 0.5, h = 4, w_helix = -20, clearance = 0.1); 
//  gear_herringbone(z = 16, m = 0.5, h = 4, w_helix = -45, clearance = 0.1); // twist independent from height
// gear_herringbone(z = 16, m = 0.5, h = 4, w_abs = -20, clearance = 0.1);  // twist absolute


//====  external splines - usage and more examples ===
// D ist calculated automatically, but can also be specified
//
// Gear(z = 10, m = 1.1, x = 0, h = 2, w = 20,  D=18, clearance = -0.2); 
// gear(z = 10, m = 1, x = .5, h = 4, w = 20, clearance = 0.2); 

// Gear_herringbone(z = 40, m = 1, h = 4, w_helix = 45, clearance = -0.2, D = 49); 
// gear_herringbone(z = 40, m = 1, h = 4, w_helix = 45, clearance = 0.2); 

// Gear_helix(z = 20, m=1.3, h = 15, w_helix = 45, clearance = -0.2); 
// gear_helix(z = 20, m=1.3, h = 15, w_helix = 45, clearance = 0.2); 


// ====  grouped examples ===
//	di = 18; //axial displacement
//	translate([di, di])   Gear(z = 25, D=32); 
//	translate([-di, di])  Gear_helix(z = 25, D=32); 
//	translate([-di, -di]) Gear_herringbone(z = 25, D=32); 
//	translate([di, -di])  Gear_bevel(z = 25, D=32); 
	
//	di = 8; //axial displacement
//	translate([di, di])   gear(); 
//	translate([-di, di])  gear_helix(); 
//	translate([-di, -di]) gear_herringbone(); 
//	translate([di, -di])  gear_bevel(); 

// profile shift examples
//	di = 9.5; //axial displacement
//	gear(z = 20, x = -.5); 
//	translate([0, di+3]) rotate([0, 0, 0]) gear(z = 7, x = 0, clearance = .2); 
//	translate([di+3.4, 0]) rotate([0, 0, 0]) gear(z = 6, x = .25); 
//	translate([0, -di-3]) rotate([0, 0, 36])   gear(z = 5, x = .5); 
//	translate([-di-3.675, 0]) rotate([0, 0, 22.5]) gear(z = 8, x = -.25); 
 

// tooth cutting principle - dumping frames for video
/*
	s = PI/6; 
	T= $t*360; 
  U = 10*PI; 
  difference()
  {
    circle(6);  // workpiece
    for(i=[0:s:T])
      rotate([0, 0, -i])
      translate([-i/360*U, 0, 0])
      Rack(m=1, rack_id=3);  // Tool
    }
	rotate([0, 0, -T])
	translate([-T/360*U, 0, 0])
    color("red")
  Rack(m=1, rack_id=3);  // Tool
*/


// === modules for internal splines
module help_gears()
{
helpstr = 
"gears library - Rudolf Huttay \n
  iterations = 150;\n
  verbose = true;\n
  help();\n
  help_gears();\n 
  gear(m = 1, z = 10, x = 0, h = 4, w = 20, clearance = 0, center = true);\n
  gear_helix(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, clearance = 0, center = true, verbose = true, slices = undef);\n
  gear_herringbone(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, clearance = 0, center = true, slices = undef);\n
  gear_bevel(m = 1, z = 10, x = 0, h = 4, w = 20, w_bevel = 45, w_helix = 45, w_abs = 0, clearance = 0, center = true);\n
  gear_info(m = 1, z = 10, x = 0, h = 0, w = 20, w_bevel = 0, w_helix = 0, w_abs=0, clearance = 0, center=true);\n
annular-toothed;\n
  Gear(m = 1, z = 10, x = 0, h = 4, w = 20, D = 0, clearance = -.1, center = true);\n
  Gear_herringbone(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, D = 0, clearance = -.1, center = true);\n
  Gear_helix(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs=0, D = 0, clearance = -.1, center = true);\n
  Gear_bevel(m = 1, z = 10, x = 0, h = 4, w = 20, w_bevel = 45, w_helix = 0, w_abs = 0, D = 0, clearance = 0, center = true);\n
2D primitives\n
  gear2D(m = 1, z = 10, x = 0, w = 20, clearance = 0, rack_id=0);\n
  Rack(m = 1, z = 10, x = 0, w = 20, clearance = 0, rack_id=0);\n
  ";
 echo(helpstr); 
}
module help() help_gears(); 
module Gear(m = 1, z = 10, x = 0, h = 4, w = 20, D = 0, clearance = 0, center = true) 
{
   D_= D==0 ? m*(z+x+4):D; 
   difference()
   {
		cylinder(r = D_/2, h = h, center = center);
		gear(m, z, x, h+1, w, center = center, clearance = clearance); 
	}
  if(verbose) echo(str("Ring (D) = ", D_)); 
}

module Gear_herringbone(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, D = 0, clearance = 0, center = true, rack_id=0)
{
   D_= D==0 ? m*(z+x+4):D; 
   difference()
   {
		cylinder(r = D_/2, h = h, center = center); // CSG!
    translate([0, 0, -.001]) 
		gear_herringbone(m, z, x, h+.01, w, w_helix, w_abs, clearance = clearance, center = center, rack_id=rack_id); 
	}
  if(verbose) echo(str("Ring (D) = ", D_)); 
}

module Gear_helix(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs=0, D = 0, clearance = 0, center = true, rack_id=0) 
{
   D_= D==0 ? m*(z+x+4):D; 
   difference()
   {
		cylinder(r = D_/2, h = h-.01, center = center); // CSG!
		gear_helix(m, z, x, h, w, w_helix, w_abs, clearance, center, rack_id); 
	}
  if(verbose) echo(str("Ring (D) = ", D_)); 
}

module Gear_bevel(m = 1, z = 10, x = 0, h = 4, w = 20, w_bevel = 45, w_helix = 0, w_abs = 0, D = 0, clearance = 0, center = true, rack_id=0)
{
   D_= D==0 ? m*(z+x+4):D; 
   rotate([0, 180, 0])
   difference()
   {
		cylinder(r = D_/2, h = h-.01, center = center); // CSG!
		gear_bevel(m, z, x, h, w, w_bevel, w_helix, w_abs, clearance = clearance, center = center, rack_id=rack_id); 
	}
  if(verbose) echo(str("Ring (D) = ", D_)); 
}


// === modules for external splines
module gear_herringbone(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, clearance = 0, center = true, slices = undef, rack_id=0)
{
  gear_info("herringbone", m, z, x, h, w, undef, w_abs==0?w_helix:undef, w_abs==0?undef:w_abs, clearance, center);
  translate([0, 0, center?0:h/2])
   for(i=[0, 1])
   mirror([0,0,i])
   gear_helix(m, z, x, h/2, w, w_helix, w_abs, center = false, clearance = clearance, verbose = false, slices = slices, rack_id=rack_id);
}

module gear_helix(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, clearance = 0, center = true, verbose = true, slices=undef, rack_id=0)
{
  if(verbose)
    gear_info("helix", m, z, x, h, w, undef, w_abs==0?w_helix:undef, w_abs==0?undef:w_abs, clearance, center);
	r_wk = m*z/2;
  tw = w_abs==0?h/tan(90-w_helix)/PI*180/r_wk:w_abs;
  sl = slices!=undef?slices:abs(tw)>0?ceil(2*h):1; 
	linear_extrude(height = h, center = center, twist = tw, slices = sl, convexity = z)
   gear2D(m, z, x, w, clearance, rack_id); 
}

module gear_bevel(m = 1, z = 10, x = 0, h = 4, w = 20, w_bevel = 45, w_helix = 0, w_abs = 0, clearance = 0, center = true, rack_id=0)
{
  gear_info("bevel", m, z, x, h, w, w_bevel, w_abs==0?w_helix:undef, w_abs==0?undef:w_abs, clearance, center);
	r_wk = m*z/2 + x; 
   sc = (r_wk-tan(w_bevel)*h)/r_wk; 
  tw = w_abs==0?h/tan(90-w_helix)/PI*180/r_wk:w_abs;
  sl = abs(tw)>0?ceil(2*h):1; 
	linear_extrude(height = h, center = center, twist = tw, scale = [sc, sc], slices = sl, convexity = z)
   gear2D(m, z, x, w, clearance, rack_id); 
}

module gear(m = 1, z = 10, x = 0, h = 4, w = 20, clearance = 0, center = true, rack_id=0)
{
  gear_info("spur", m, z, x, h, w, undef, undef, undef, clearance, center); 
	linear_extrude(height = h, center = center, convexity = z)
    gear2D(m, z, x, w, clearance, rack_id);
}

module gear_info(type = "", m = 1, z = 10, x = 0, h = 0, w = 20, w_bevel = 0, w_helix = 0, w_abs=0, clearance = 0, center=true, D=undef)
{
  	r_wk = m*z/2 + x; 
   	dy = m;  
  	r_kk = r_wk + dy;   
  	r_fk = r_wk - dy;  
  	r_kkc = r_wk + dy *(1-clearance/2);   
  	r_fkc = r_wk - dy *(1+clearance/2);  
  if(verbose) 
  {
   echo(str ("\n")); 
   echo(str (type, " gear")); 
   echo(str ("modulus (m) = ", m)); 
   echo(str ("teeth (z) = ", z)); 
   echo(str ("profile angle (w) = ", w, "°")); 
   echo(str ("pitch (d) = ", 2*r_wk)); 
   echo(str ("d_outer = ", 2*r_kk, "mm")); 
   echo(str ("d_inner = ", 2*r_fk, "mm")); 
   echo(str ("height (h) = ", h, "mm")); 
   echo(str ("clearance factor = ", clearance)); 
   echo(str ("d_outer_cleared = ", 2*r_kkc, "mm")); 
   echo(str ("d_inner_cleared = ", 2*r_fkc, "mm")); 
   echo(str ("helix angle (w_helix) = ", w_helix, "°")); 
   echo(str ("absolute angle (w_abs) = ", w_abs, "°")); 
   echo(str ("bevel angle (w_bevel) = ", w_bevel, "°")); 
   echo(str ("center  = ", center)); 
  }
}

// === from here 2D stuff == 
module gear2D(m = 1, z = 10, x = 0, w = 20, clearance = 0, rack_id=0)
{
  	r_wk = m*z/2 + x; 
    U = m*z*PI; 
   	dy = m;  
  	r_fkc = r_wk + 2*dy *(1-clearance/2);  
  s = 360/iterations; 
  difference()
  {
    circle(r_fkc, $fn=300);  // workpiece
    for(i=[0:s:360])
      rotate([0, 0, -i])
      translate([-i/360*U, 0, 0])
      Rack(m, z, x, w, clearance, rack_id);  // Tool
  }
}
 
module Rack(m = 2, z = 10, x = 0, w = 20, clearance = 0, rack_id=0)
{
    if (rack_id == 1) polygon(rack1(m, z, x, clearance));
    else if (rack_id == 2) offset(r=clearance/m) polygon(rack2(m, z, x));
    else if (rack_id == 3) offset(r=clearance/m) polygon(rack3(m, z, x));
    else if (rack_id == 4) offset(r=clearance/m) polygon(rack4(m, z, x));
    else if (rack_id == 5) offset(r=clearance/m) polygon(rack5(m, z, x));
    else polygon(rack0(m, z, x, w, clearance)); // default
}

// normal (default) trapezoid teeth
function rack0(m = 2, z = 10, x = 0, w = 20, clearance = 0) = 
  let (dx = 2*tan(w),
  c = clearance/m,
  o = dx/2-PI/4,
  r = z/2 + x + 1,
  X=[c, PI/2-dx-c, PI/2-c, PI-dx+c],
  Y=[r-c, r-c, r-2-c, r-2-c])
  m*concat([[-PI+o, r+5]], 
           [for(i=[-1:z], j=[0:3]) [o+i*PI+X[j], Y[j]]], 
           [[o+PI*(z+1)+c, r-c], [o+PI*(z+1)+c, r+5]]); 

// tilted trapezoid teeth with one perpendicular side side and rounded corners
function rack1(m = 2, z = 10, x = 0, clearance = 0) =
  let (dx = PI/16,
  c = clearance/m,
  o = -PI/4,
  r = z/2 + x + 1,
  dxm = 0.33*dx,
  X = [c,      dxm+c,   dx+c, PI/4-c-dxm, PI/4-c+dxm, 3*PI/4-c-dxm, 3*PI/4-c+dxm, PI-dx+c, PI-dxm+c,  PI+c],
  Y = [r-dx-c, r-dxm-c, r-c,  r-c,        r-c-dxm,    r-2-c+dxm,    r-2-c,        r-2-c,   r-2-c+dxm, r-2-c+dx])
  m*concat([[-PI+o, r+m+2]],
           [for(i=[-1:z], j=[0:9]) [o+i*PI+X[j], Y[j]]], 
           [[o+PI*(z+1)+c, Y[0]], [o+PI*(z+1)+c, r+m+2]]); 

// sinewave teeth
function rack2(m=2, z=10, x=0) =
    let(
    r = z/2 + x + 1,
    Y = [ for(a=[0:5:179]) sin(2*a)+r-1 ],
    X = [ for(a=[0:5:179]) a*PI/180 ],
    o = -PI/4,
    n = len(X)-1)
    m*concat([[-PI+o, r+m+2]],
           [for(i=[-1:z], j=[0:n]) [o+i*PI+X[j], Y[j]]], 
           [[o+PI*(z+1), Y[0]], [o+PI*(z+1), r+m+2]]);

// tilted sinewave teeth
function rack3(m=2, z=10, x=0) =
    let(
    r = z/2 + x + 1,
    y0 = [ for(a=[0:5:180]) tiltsin(a) ],
    ymax = max(y0),
    ymin = min(y0),
    y1 = (2/(ymax-ymin))*y0,
    Y = [ for(a=y1) a+r-1 ],
    X = [ for(a=[0:5:179]) a*PI/180 ],
    o = -PI/4,
    n = len(X)-1)
    m*concat([[-PI+o, r+m+2]],
           [for(i=[-1:z], j=[0:n]) [o+i*PI+X[j], Y[j]]],
           [[o+PI*(z+1), Y[0]], [o+PI*(z+1), r+m+2]]); 

function tiltsin(x) =
    let(t=0.618, a = 2*x+90) 1/t*atan(t*sin(a)/(1-t*cos(a)));

// semicircle teeth
function rack4(m=2, z=10, x=0) =
    let(
    r = z/2 + x + 1,
    cr = PI/4,
    X = concat([ for(a=[0:5:179]) cr - cr*cos(a) ], [ for(a=[0:5:179]) 3*cr - cr*cos(a) ]),
    Y = [ for(a=[0:5:359]) -cr*sin(a) + r-cr ],
    o = -PI/4,
    n = len(X)-1)
    m*concat([[-PI+o, r+m+2]], 
           [for(i=[-1:z], j=[0:n]) [o+i*PI+X[j], Y[j]]], 
           [[o+PI*(z+1), Y[0]], [o+PI*(z+1), r+m+2]]);

/*
// original attempt at cycloid - single cycloid wave scaled to size
function rack5a(m=2, z=10, x=0) =
    let(
    r = z/2 + x + 1,
    cr = 1,
    X = concat([ for(a=[0:10:359]) 0.25*cr*(1-sin(a)) + PI*cr*a/720 ], [ for(a=[0:10:359]) 0.25*cr*(1-sin(a))+PI/2+PI*cr*a/720 ]),
    Y = concat([ for(a=[0:10:359]) cr*(1-cos(a))/2+r-cr ], [ for(a=[0:10:359]) -cr*(1-cos(a))/2+r-cr ]),
    o = -PI/4,
    n = len(X)-1)
    m*concat([[-PI+o, r+m+1]], 
           [for(i=[-1:z], j=[0:n]) [o+i*PI+X[j], Y[j]]], 
           [[o+PI*(z+1)+X[0], Y[0]], [o+PI*(z+1)+X[0], r+m+1]]);
*/

// cycloid rack using portions of cycloids
cycloidside1 = [
    [0,0],
    for(a=[9:6:72]) [a*PI/180-sin(a), 1-cos(a)],
    for(a=[75:3:89]) [a*PI/180-sin(a), 1-cos(a)],
    [PI/2-1.01,0.975], [PI/2-0.965,0.992], [PI/2-0.92,1] // fillet
];
cycloidside2 = [ for(i=[len(cycloidside1)-1:-1:0]) [ 0.5*PI-cycloidside1[i][0], cycloidside1[i][1] ] ];
cycloidtooth = concat(cycloidside1, cycloidside2);

function rack5(m=2, z=10, x=0) =
    let(
    tlen = len(cycloidtooth)-1,
    r = z/2 + x + 1,
    X = [ for(i=[0:tlen]) cycloidtooth[i][0], for(i=[0:tlen]) cycloidtooth[i][0]+0.5*PI ],
    Y = [ for(i=[0:tlen]) cycloidtooth[i][1]+r-1, for(i=[0:tlen]) -cycloidtooth[i][1]+r-1 ],
    o = -PI/4,
    n = len(X)-1)
    m*concat([[-PI+o, r+m+2]], 
           [for(i=[-1:z], j=[0:n]) [o+i*PI+X[j], Y[j]]], 
           [[o+PI*(z+1)+X[0], Y[0]], [o+PI*(z+1)+X[0], r+m+2]]);
