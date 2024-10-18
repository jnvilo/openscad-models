

module cover(){

    difference(){
    cube([40,25,4],center=true);
    cube([20,13,10], center=true);
    }

}

px=45;
py=25;
pz=15;


//cylinder(h=30,r=4,center=true);

module box(bx,by,bz){

    hull(){
        for ( x = [-bx/2:bx:bx/2]){
            for ( y = [-by/2:by:by/2]){

            translate([x, y, 0]) cylinder(h=bz,r=4,center=true);
            }
           }
       }    
    
   }
 
 w=4;
  
 module body(){ 
     difference(){
        box(px,py,pz);
        color("blue") translate([0,0,w]) box(px-2*w,py-2*w,pz);
     }
 }     
 
 module cover(){
 
 translate([0,0,pz]) box(px,py,2);
 translate([0,0,pz-2]) box(px-2*w-0.5,py-2*w-0.5,2);
 
 }
 
 cover();
 
 difference(){
 body();
 rotate([0,90,0]) cylinder(h=200,r=2.5,center=true);
 }