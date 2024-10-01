use <yellow_motor.scad>;


module motor(){
color("blue") yellow_motor();
}




l=80;
h=22;
w = 1.5;

bwhlr = 35/2;
swhlr = 23/2;
wheelw = 3.5;

side = 19/2+w/2;

module body(){
    translate([0,side,0])
    cube([l,w,h],center=true);

    translate([0,-side,0])
    cube([l,w,h],center=true);

    translate([39.25,0,0])
    cube([w,19,h],center=true);
    translate([-39.25,0,0])
    cube([w,19,h],center=true);
}


module big_wheel(){

    rotate([90,0,0]){
    //cylinder(r=1.5,h=100,center=true,$fn=32);
    cylinder(r=bwhlr,h=wheelw,center=true,$fn=24);
    }
} 



wheel_y = side + wheelw+0.5;
wheel_x = 27.7;
wheel_shaft = 2;

//the distance to push the shaft of the small
//wheel down to match the big wheel.
delta = bwhlr - swhlr;

module small_wheel(){
    rotate([90,0,0]){
    cylinder(r=wheel_shaft+0.2,h=100,center=true,$fn=32);
    cylinder(r=swhlr,h=wheelw,center=true);
    }
    }

////translate([wheel_x,wheel_y,0]) big_wheel();
//translate([-(wheel_x+7),wheel_y,-delta]) small_wheel();

module big_wheel_rod(){
    rotate([90,0,0]){
    cylinder(r=2,h=100,center=true,$fn=64);
    //cylinder(r=bwhlr,h=wheelw,center=true);
    }
}
    


module make_big_wheel(){
    difference(){
        translate([wheel_x,wheel_y,0]) big_wheel();
        translate([20,0,0]) motor() motor();
        }
    }
      
   

//translate([20,0,0]) motor() motor();

module motor_shaft_cutter(){
    difference(){    
     {rotate([90,0,0]) cylinder(r=5.5/2,h=100,center=true,$fn=32);}

    translate([3.5/2+1,0,0]) {
        color("blue") 
        cube([1.9,102,10],center=true);
        }
        
    translate([-(3.5/2+1),0,0]) {
        color("blue") 
        cube([1.9,102,10],center=true);
    }
        
    }    
}

module printable_wheel(){
difference(){
big_wheel();
motor_shaft_cutter();
}
}


module groove(){
 cylinder(h=100,r=2,center=true);
}


radius = bwhlr-0.5;  // Radius of the circle along which spheres are arranged
num_spheres = 32;  // Number of spheres to place around the circle
sphere_radius = 1;  // Radius of each sphere

// Main loop to create spheres around a circle
for (i = [0 : 360/num_spheres : 360]) {
    // Rotate and translate each sphere
    translate([radius * cos(i),0,  radius * sin(i)]) {
        //sphere(r = sphere_radius);
        rotate([90,0,0]) cylinder(h=wheelw,r=1,center=true);
        }
}

difference(){
union(){

difference(){
    big_wheel();
   
    rotate([90,0,0]){
    num_spokes=16;

    difference(){
        color("blue") cylinder(h=wheelw+5, r=bwhlr -1,center=true); 
        
        for (i=[0:360/num_spokes: 360]){    
        rotate([0,0,i])    
        translate([0,0,0])cube([1,40,20],center=true);    
        }
      }
   
    }
}

rotate([90,0,0]) cylinder(h=wheelw,r=bwhlr-10,center=true);
}

motor_shaft_cutter();
}