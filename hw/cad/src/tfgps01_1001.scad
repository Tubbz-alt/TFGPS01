
include <bolt_parameters.scad>

/*
vyska = 20;

difference(){
sphere(r = 10);
#cube(10, center = true);
translate([0, 0, vyska/2]) cube([5, 5, vyska], center = true);
}

*/


connector_i2c = true;
connector_autopilot = true;
switch = true;
Payload = true;
konektor_usb = true;

D3 = true;
D4 = true;
D5 = true;
D6 = true;
D7 = true;

wall = 2;

antenna_size = 35+1;
antenna_thickness = 4.5;

antenna_solid_layer = 0.5;
led_solid_layer = 0.3;

pcb_size = 51+1;
pcb_thickness = 7.3;

pacicky_cube = 70;

module gps_krabicka(){

	difference(){
		translate([0, 0, (antenna_thickness+pcb_thickness+wall-antenna_solid_layer)/2])
			cube([pcb_size+2*wall, pcb_size+2*wall, antenna_thickness+pcb_thickness+antenna_solid_layer+wall], center = true);


		for (x = [1, -1], y=[1, -1])
			translate([20*x, 20*y, (antenna_thickness+pcb_thickness+antenna_solid_layer+wall+1)/2 - antenna_solid_layer])
				cylinder(d = M3_screw_diameter, h=antenna_thickness+pcb_thickness+antenna_solid_layer+wall+1+0.1, center = true, $fn = 21);


		translate([0, 0, antenna_thickness/2])
			cube([antenna_size, antenna_size, antenna_thickness], center = true);

		translate([0, 0, (pcb_thickness+wall+1)/2+antenna_thickness])
			cube([pcb_size, pcb_size, pcb_thickness+wall+1+0.1], center = true);

		//pípák
		translate([-9.5-0.88, (pcb_size+wall)/2, 4.33+antenna_thickness+1.5/2-0.8])
			cube([4+0.88, wall+1, 1.5], center = true);

		//otvor konektoru I2C
		if(connector_i2c)
		translate([-(pcb_size+wall)/2, 11.3-0.59, antenna_thickness + 0.7])
			translate([0, 0, 10])
				cube ([wall+1, 8.7+1, 20], center = true);

		//Konektor autopilot
		if(connector_autopilot)
		translate([-(pcb_size+wall)/2, -6.86-0.27, antenna_thickness + 0.7])
			translate([0, 0, 10])	
				cube([wall+1, 15.75 + 1, 20], center = true);

		//Tlačítko switch 
		if(switch)
		translate([(pcb_size+wall)/2, 8.1+0.42, antenna_thickness + 0.7])
			translate([0, 0, 10])
				cube([wall+1, 10.75+1, 20], center = true);

		//Payload
		if(Payload)
		translate([(pcb_size+wall)/2, -8.1+0.5, antenna_thickness + 0.7])
			translate([0, 0, 10])
				cube([wall+1, 13.22+1, 20], center = true);

		//konektor_usb
		if(konektor_usb)
		translate([10+1+0.8, -(pcb_size+wall)/2, antenna_thickness + 0.7])
			translate([0, 0, 5.87/2])
				cube([9.3+1, wall+1, 5.87], center = true);

		translate([10+1+0.8, -(pcb_size+wall)/2-(wall+1)/2, antenna_thickness + 0.7-1])
			translate([0, 0, 7.87/2])
				cube([9.3+1+2, wall+1, 7.87], center = true);
		//diody :DDDDDDDDD
		translate([0, 0, -antenna_solid_layer]){
			if(D3)
				translate([3.17, -21.495, led_solid_layer])
					cylinder(d = 2.7, h=20, $fn = 21);

			if(D4)
				translate([9.3, 20.86, led_solid_layer])
					cylinder(d = 2.7, h=20, $fn = 21);

			
			if(D5)
				translate([5.8, 20.86, led_solid_layer])
					cylinder(d = 2.7, h=20, $fn = 21);


			if(D6)
				translate([2.4, 20.86, led_solid_layer])
					cylinder(d = 2.7, h=20, $fn = 21);

			if(D7)
				translate([12.7, 20.86, led_solid_layer])
					cylinder(d = 2.7, h=20, $fn = 21);
		
		}
	}
}


module gps_pacicky(){
	difference(){
		translate([0, 0, -antenna_solid_layer+(wall+5)/2])	
			cube([pacicky_cube, pcb_size+2*wall, wall+5], center = true);

		translate([0, 0, -antenna_solid_layer+(wall+5)/2+wall*1.5])	
			cube([pacicky_cube-4, pcb_size+2*wall, wall+8.5], center = true);

			cube([pcb_size+2*wall, pcb_size+2*wall, +100], center = true);
		
			for(x = [-1, 1])
			translate([0, x*((pcb_size)/2-5), (wall+5)/2])
				rotate([0, 90, 0]){
					cylinder(d = M3_screw_diameter, h = 77, $fn = 21, center = true);
					rotate([0,0,30]) cylinder(d = M3_nut_diameter, h = 70-2, $fn = 6, center = true);
				}
	}
}



module gps_vicko(){
	difference(){
		translate([0, 0, antenna_thickness+pcb_thickness+wall/2+wall])
			cube([pcb_size+2*wall, pcb_size+2*wall, wall], center = true);
		for (x = [1, -1], y=[1, -1])
			translate([20*x, 20*y, (antenna_thickness+pcb_thickness+antenna_solid_layer+wall+1)/2 - antenna_solid_layer])
				cylinder(d = M3_screw_diameter, h=20, center = true, $fn = 21);


	}
}




gps_pacicky();
gps_krabicka();
//gps_vicko();