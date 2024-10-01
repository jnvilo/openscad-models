$fn=30;

width = 155;
length = 260;
height = 50;

edge_r = 20;

/***
Main Body Hull
**/

module edges_parts(h){
    translate([0, length/2-edge_r,0]){
        cylinder(h,r=edge_r,center=true);
    }

    translate([0, -length/2+edge_r,0]){
        cylinder(h,r=edge_r,center=true);
    }
}


module edges(){
    
    translate([width/2-edge_r,0,0]) { 
        edges_parts(height);
        }
 
    
        
    translate([-width/2+20,0,height/2-20]){
    rotate([90,0,0]) cylinder(h=length-20,r=20,center=true);
    }
    cube_d = height;

    translate([-(width/2-cube_d/2),0,-(height/2-cube_d/4)])
    cube([cube_d,length-edge_r,height/2],center=true);
        
    
}

 l = 100;
 h = 15;
 w = 50;  
 dw = 20;    
 disp=0;
//hull() edges();
module cutout_edge_right(){
    
polyhedron(    
        points=[
               [w,0,0], 
                [0,l,0], 
                [w,l,0],
                [w,l,-h]
        ],
        faces = [
            [ 0,1,2],
            [0,2,3],
        [1,3,2], [1,0,3]]
            
  );
}

module cutout_edge_left(){
    
polyhedron(    
        points=[
               [w,0,0], 
                [0,-l,0], 
                [w,-l,0],
                [w,-l,-h]
        ],
        faces = [
            [ 0,1,2],
            [0,2,3],
        [1,3,2], [1,0,3]]
            
  );
}



//cutout_x = 50;


module corner_bottom_left(){
 translate([width/2-w/2+disp,length/2-l/2,height/2-h/2]) {
    translate([-w/2,-l/2,h/2])color("red") cutout_edge_right();
 }
}

//translate([0,0,-5]) hull() edges();

module corner_bottom_right(){
translate([width/2-w/2+disp,-length/2+l/2, height/2-h/2]){
 translate([-w/2,l/2,h/2]) //center it
 color("blue") cutout_edge_left();
}
}




module body(){
    hull() edges(); 
}

//edges();
//body();

module main(){
difference(){
    body();
    corner_bottom_left();
    corner_bottom_right();
    sloped_side_cutout();

}
}



module sloped_side_cutout(){
cx = 200;
cy = 20;
cz = 20;
zcut = 2;

//translate([cx/,0])
translate([0,length/2,height/2+zcut]){
rotate([45,0,0]) color("blue") cube([cx,cy,cz],center=true);
}

translate([0,-length/2,height/2+zcut]){
rotate([45,0,0]) color("blue") cube([cx,cy,cz],center=true);
}
}


walls = 6;
nx = width - walls;
ny = length - walls;
nz = height - walls;
module inner_box(){
    
    resize([nx,ny,nz]) main();
}


module main_box(){

    difference(){
        main();
        inner_box();
      //  cube([200,200,200]);
      // translate([60,-200,0]) cube([200,200,200]);

    }
}


button_w = 84;
button_l = 124;
button_h = height+2;
button_s = 4;

stick_w=94;
stick_l = 54;
stick_h = height+5;
stick_s = 4;

module main_box_with_holes(){

difference(){
    main_box();

    translate([-10,50,4])
    cube([button_w,button_l, button_h],center=true);

    translate([-10,-70,6])
    cube([stick_w,stick_l, stick_h],center=true);
}

}


module left_side(){

    difference(){
        main_box_with_holes();
        translate([0,70,0])
        cube([200,200,100],center=true);
    }

}

module right_side(){
    
    difference(){
        main_box_with_holes();
        translate([0,-130,0])
        cube([200,200,100],center=true);
    }
    
}

module top_left(){
difference(){
    left_side();
    translate([0,0,-20])
    cube([400,400,30],center=true);

}
}

module top_right(){

difference(){
    right_side();
    
    translate([0,0,-20])
    cube([400,400,30],center=true);
}    
}


top_right();

/**
translate([-button_w/2-10,45,10])
cube([button_s, button_l,height-4],center=true);

translate([button_w/2-10,50,0])
cube([button_s, button_l,height-4],center=true);

**/

//translate([-35,0,0])
//cube([80,35,200],center=true);



