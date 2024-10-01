use <gears_mod.scad>;

module motor_gear(){
    difference(){
    gear_bevel(z=12, m=1, x=0.5); 
    cylinder(100,1.2,$fn=32,center=true);
    }
}

module motor_gear_big(){
    difference(){
    gear_bevel(z=24, m=1, x=0.5,h=5); 
    cylinder(100,r=2.8,$fn=32,center=true);
    }
}


module small_gear(){
    translate([0,-12,0]){
    rotate([-90,0,0])
    motor_gear();
    }
}

module big_gear(){
    translate([-4,0,0]){
    rotate([0,90,0])
    motor_gear_big();
    }
}


module base(){
    //base
    hull(){
    translate([0,0,-19])
    cube([35,50,2],center=true);
    translate([0,-30,-19])
    color("blue") cube([15,25,2],center=true);
    }
}

module motor_placeholder(){
    //motor placeholder
    translate([0,-30,0])
    cube([15,25,15],center=true);
}


module motor_base(){
    //motor base
    translate([0,-30,-7.5-12.5/2])
    color("red") cube([15,25,12.5],center=true);
}

module side(){

    difference(){
    hull(){
    rotate([0,90,0])
    cylinder(h=4,r=10,center=true);
    translate([0,0,-18])cube([4,30,4],center=true);
    }


    rotate([0,90,0])
    cylinder(100,r=2.2,center=true,$fn=12);
    }
}

module print(){
base();
motor_base();
translate([-14,0,0]) side();
translate([14,0,0]) side();
big_gear();
}

module s1_gear(){
difference(){
gear(z=12, m=1, x=0.5,h=10);
cylinder(h=50,r=2.2,center=true);
}
}

print();

// gear(rack_id=2);
// gear_helix(); 
// gear_herringbone(); 
//gear_bevel(); 

