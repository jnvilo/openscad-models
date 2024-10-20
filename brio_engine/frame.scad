use <yellow_motor.scad>;


module motor(){
//translate([0,0.6,0])
rotate([180,0,0])
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
 
    translate([l/2-w/2,0,0])
    cube([w,19,h],center=true);
    translate([-(l/2-w/2),0,0])
    cube([w,19,h],center=true);
}



module motor_shaft_cutter(){

    translate([0,0,-10]) {
        color("red") 
        cube([8,102,20],center=true);
    }

    difference(){    
     {rotate([90,0,0]) cylinder(r=5,h=100,center=true,$fn=32);}

    /*
    translate([3.5/2+1.5,0,0]) {
        color("blue") 
        cube([1.9,102,10],center=true);
        }
        
    translate([-(3.5/2+1.55),0,0]) {
        color("red") 
        cube([2,102,10],center=true);
    }*/
        
    }  
  
  
  //let notch for protruding round 
   translate([-12,-10,-11]) {
        color("red") 
        cube([6,20,20],center=true);
   }

  translate([-12,-10,-1]){
        rotate([90,0,0]) cylinder(r=3,h=20,center=true,$fn=32);
       }
    
       
    //for motor square notch
    translate([-32,0,-6])
    cube([6,30,20],center=true);

}


motor_disp = l/2-20;  //the amount to move motor to the +x
cutter_disp = l/2-20 +7.6; //the amount to move cutter relative to motor

//translate([motor_disp-0.5,0,0]) motor();


module frame(){
    difference(){
    body();

    translate([cutter_disp,0,0])motor_shaft_cutter();
    translate([-(l/2-10),0,0]){
    rotate([90,0,0]) cylinder(r=2.1,h=100,center=true,$fn=32);
    }

    }

}

rotate([180,0,0]) frame();