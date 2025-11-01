// vase mode parametric funnel v2
// by DrJones   printables.com/@DrJones   makerworld.com/@DrJones  
// license: CC-BY

//Printing: 
//   use VASE MODE and 
//   set EXTUSION WIDTH (LINE WIDTH) to 0.7mm

//outer diameter in mm
diameter=70;  //[20:150]
//cone angle in degrees
cone_angle=60;  //[30:100]
//stem diameter (where it meets the cone)
stem_diameter=12;  //[10:60]
//length of stem
stem_length=50; //[5:150]
//stem taper; diameter reduction at the end in %
stem_taper=15; //[0:50]
//channel diameter for air to escape, in % of stem diameter
air_gap=40; //[0:70]

//Type of "turbo" fins; these fins are also good for holding filter paper with a gap to the funnel wall
fintype=2; //[0:off, 1:common fins, 2:improved]
//number of fins
fins=10; //[0:15]
//twist angle for fins
fintwist=45; //[0:60]
//twist direction
findir=0; //[0:clockwise, 1:counterclockwise]
//depth of fins
findepth=3; //[1:8]

/* [Hidden] */
h=(diameter-stem_diameter)/2/tan(cone_angle/2);
aird=stem_diameter*air_gap/100;

$fn=90;

difference(){
  union(){
    cylinder(h=h,d1=diameter,d2=stem_diameter);
    up(h) cylinder(h=stem_length,d1=stem_diameter,d2=stem_diameter*(1-stem_taper/100)); 
  }
  if(air_gap>0)airgap();  if(fintype==1)fins();  if(fintype==2)fins2();
}
tra(x=diameter/2-1*tan(cone_angle/2)) cylinder(h=2,d=5+diameter*.05);

module airgap($fn=48){
  angle1=cone_angle/2+aird*cos(cone_angle/2)*28.6/(h-2);//atan((diameter/2+aird/2-stem_diameter/2)/(h-2));
  angle2=atan((stem_diameter*stem_taper/100)/2/stem_length);
  tra(x=stem_diameter/2,z=h) {
    sphere(d=aird);
    rot(y=180-angle1) cylinder(h=sqrt(diameter*diameter/4+h^2), d=aird);
    rot(y=-angle2) cylinder(h=stem_length+10,d=aird);
  }
}
module fins(){ difference(){
  mirror([0,findir,0])union()for(a=[2.5+360/diameter:360/fins:359])rotate([0,0,a])
    linear_extrude(h,twist=-tan(fintwist)*2*57.3*h/diameter)tra(x=stem_diameter/2+3)square([diameter/2,0.1]);
  cylinder(h=h-findepth,d1=diameter-2*findepth,d2=stem_diameter);
}}
module fins2(n=12){hh=h/n;q=-tan(fintwist)*2*57.3*hh;
  module sub(i){if(i<n){dd=(diameter+(i+.5)*hh/h*(stem_diameter-diameter)); tw=q/dd; 
    for(a=[2.5+360/diameter:360/fins:359])rotate([0,0,a]) linear_extrude(hh,twist=tw)tra(x=stem_diameter/2+3)square([dd/2,0.1]); 
    up(hh)rot(z=-tw)sub(i+1); }}
  mirror([0,findir,0])difference(){ sub(0); cylinder(h=h-findepth,d1=diameter-2*findepth,d2=stem_diameter); }
}

module tra(x=0,y=0,z=0) { translate([x,y,z]) children(); }
module up(z) { translate([0,0,z]) children(); }
module rot(x=0,y=0,z=0) {rotate([x,y,z]) children(); }



