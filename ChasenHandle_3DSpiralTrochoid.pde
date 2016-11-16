


// 3D screen display
final float DIST_= 200.0;// initial camera distance
float distance= DIST_;
float magnify = 1.0;


// 3D construction
final float speedFactor =5.0; //times fast to the unit
final float flowSpeed =300.0; //unit speed of extruler
final float feedSpeed =960.0; //unit speed of the head movement
final float temperature =220.0; //degree C

// output to a file
PrintWriter output;
final String outputFilename= "out03050.bfb";
final float center_x= 10.0, center_y= 10.0, center_z= 0.0;  // transposed center

// data to display and output to a file
g1[] body;
g1[] raft;
float lx=0.0, ly= 0.0,lz=0.0;// last x,y,z

void setup() {
  size(800, 800, P3D);
  noFill();
  frameRate(8);
  
  // data generation
  raft= generate_raft();
  body= generate_body();
} //<>// //<>//

void draw() {
  background(10);
  //translate(50, 50, -50);
  float rotate_X = PI * (mouseX-height)/height;
  float rotate_Y = PI * (mouseY-width)/width;
  //set camera
  // distance can be controlled by mouse scroll
  camera(distance*cos(rotate_X), distance*cos(0.5*rotate_Y), distance*cos(-1*rotate_Y),
        0.0, 0.0, 50.0,   0.0, 1.0, 0.0);
        
  draw_axis_box();
        
    stroke(240,100,100);    
  draw_data(raft);
  
    stroke(150,240,150);
  draw_data(body);
  
  
} //end of draw()

void draw_data(g1[] data) {
  
  for (int i = 0; i < data.length; i++) {
      line(lx,ly,lz, data[i].x,data[i].y,data[i].z);  
      lx= data[i].x;
      ly= data[i].y;
      lz= data[i].z;
  }

}

void draw_axis_box() {  
  stroke(50,128);
  box(100);
  
  pushMatrix();
    stroke(128);
    translate(0, 0, -50);
    rect(-50.0,-50.0, 100.0,100.0);
  popMatrix();

    stroke(255,180,180);//X --RED
    line(0,0,0, 200,0,0);
    
    stroke(180,255,180);//Y --GREEN
    line(0,0,0, 0,200,0); 
    
    stroke(180,180,255);//Z -- BLUE
    line(0,0,0, 0,0,200); 
}


g1[] generate_raft(){
  ArrayList<g1> tmp = new ArrayList<g1>();
  g1[] ret;
  
  float x,y, z= 1.0; //mm
  float rad, deg= 0.0;
  float radius= 9.0; //mm  40mm diameter
  float radiusDelta= 4.0; //mm
  float division= 13.0;//degree

  // output.println("G1 X"+lx+" Y"+ly+" Z"+lz+" F960.0");
  // tmp.add(new g1(lx,ly,lz,flow));
  for(deg= 0.0; deg <=360.0; deg+= division) {
      rad = radians(deg);
      float delta = deg%2>0? radiusDelta : -1*radiusDelta;
      float head_speed = 960.0;
      x= cos(rad) * (radius + delta);
      y= sin(rad) * (radius + delta);
      z= 0.0;

      lx=x; ly=y; lz=z;
      lx= round(lx *1000.0)/1000.0;
      ly= round(ly *1000.0)/1000.0;
      //lz= round(z *1000.0)/1000.0;  //raft is Z0.0 all the time
      //lf= round(flow *10.0)/10.0;
      tmp.add(new g1(lx,ly,lz,head_speed));
  }
  
  // converting ArrayList<> to Array[]
  ret= new g1[tmp.size()];
  for(int i=0;i<tmp.size(); i++) {
    ret[i]=tmp.get(i);
  }
  return ret;
}

g1[]  generate_body() {
  ArrayList<g1> tmp = new ArrayList<g1>();
  g1[] ret;
  
  float z= 0.5; //mm  starting Z
  float radius1= 6.0; //mm
  float radius2= radius1 *1.45; //mm
  
  float rad, deg= 0.0;
  float x,y, xc,yc, xr,yr;
  final float feedrate = round((feedSpeed * speedFactor)*10)/10;
  final float division= 1.0;//degree
  final float division360= 360.0/division;//degree
  final float layer= 0.4;//mm
  final float layer360= layer/division360; //mm/division
  
  final float group1= 40.0; //mm
  final float group2= 55.0; //mm
  final float group3= 60.0; //mm
  
  lx=radius1;
  ly= 0.0;
  lz=0.0;
  
  for(;z< group1;) {
    radius2= radius1 *(1.45 -cos(lz/7)*0.1);
    for(deg= 0.0; deg <=360.0; deg+= division) {
      rad = radians(deg);
      x= cos(rad) * radius1 + sin(rad*6) * radius2;
      y= sin(rad) * radius1 + cos(rad*6) * radius2;
      z+= layer360;

      lx=x; ly=y; lz=z;
    
      lx= round(lx *1000.0)/1000.0;
      ly= round(ly *1000.0)/1000.0;
      lz= round(lz *1000.0)/1000.0;
      
      tmp.add(new g1(lx,ly,lz,feedrate));
    }
    radius1 += sin(lz/5)*0.015;
  }

  for(z= group1; z< group2;) {
    radius2= radius1 *(1.45 -cos(lz/7)*0.1);
    for(deg= 0.0; deg <=360.0; deg+= division) {
      rad = radians(deg);
      x= cos(rad) * radius1 + sin(rad*6) * radius2;
      y= sin(rad) * radius1 + cos(rad*6) * radius2;
      z+= layer360;

      lx=x; ly=y; lz=z;
    
      lx= round(lx *1000.0)/1000.0;
      ly= round(ly *1000.0)/1000.0;
      lz= round(lz *1000.0)/1000.0;
      
      tmp.add(new g1(lx,ly,lz,feedrate));
    }
    radius1 += sin(lz/5)*0.015;
  }

  // converting ArrayList<> to Array[]
  ret= new g1[tmp.size()];
  for(int i=0;i<tmp.size(); i++) {
    ret[i]=tmp.get(i);
  }
  return ret;
}

//
// output a file --- triggered by pressing W or S key (for write/save)
//
void writeBFB() {
  //opening the output file
  output =  createWriter(outputFilename);

  // warming up
  //http://forums.reprap.org/read.php?151,70890,70992
  output.println("M227 P3200 S3200");
  output.println("M105");//Custom code for temperature reading. (Not used)
  output.println("M113 S1.0");  //Set Extruder PWM http://reprap.org/wiki/G‐code#M113:_Set_Extruder_PWM
  output.println("M108 S600.0");   // Set Extruder speed to (S value/10)rpm.
  output.println("M542");  //Enter 3000 nozzle wipe / move to RapMan rest location
  output.println("M107");          // Fan STOP
  output.println("M104 S220");     // Extruder temperature 220 degC
  output.println("M106");          // Fan START
  output.println("M551 P57600 S600");//Prime extruder 1. Parameter P= stepper steps, S= RPM * 10
  output.println("M543");  //Exit 3000 nozzle wipe / does nothing on RapMan
  output.println("M107");          // Fan STOP
  //output.println("G1 X0.0 Y0.0 Z0.0 F30000.0");
  output.println("G1 X"+center_x+" Y"+center_y+" Z"+center_z+" F30000.0"); //new in TubeTest_0
  output.println("M106");          // Fan START
  output.println("M101");          // Turn extruder on (forward/filament in).
  
  // Raft part
  //PVector tran = new PVector(center_x, center_y, center_z);
  for (g1 part : raft) {
     //output.println(part.toString());
     //part.add(tran);  // this cause the translation of the data
     /*float px= round((part.x +center_x) *1000.0)/1000.0;
     float py= round((part.y +center_y) *1000.0)/1000.0;
     float pz= round((part.z +center_z) *1000.0)/1000.0;
     float pf= round(part.flow *10.0)/10.0;
     output.println("G1 X"+px+" Y"+py+" Z"+pz+" F"+pf );
     */
     output.println(part.toStringTranslated(center_x, center_y, center_z));
  }
  
  final float speed = round((flowSpeed * speedFactor)*10)/10;
  
    // prepare for body
    output.println("M103");        // Turn ALL extruder off.
    output.println("M104 S"+temperature);     // Extruder 1 temperature 200 degC  // new in TubeTest_0
    output.println("G1 X"+center_x+" Y"+center_y+" Z"+center_z+" F30000.0"); //new in TubeTest_0
    output.println("M108 S"+speed); // Set Extruder 1 speed to (S value/10)rpm.
    output.println("M106");          // Fan START
    output.println("M101");          // Turn extruder 1 on (forward/filament in).
  
  // main body part  
  for (g1 part : body) {
     //output.println(part.toString());
     //part.add(tran);  // this cause the translation of the data
     float px= round((part.x +center_x) *1000.0)/1000.0;
     float py= round((part.y +center_y) *1000.0)/1000.0;
     float pz= round((part.z +center_z) *1000.0)/1000.0;
     float pf= round(part.feed *10.0)/10.0;
     output.println("G1 X"+px+" Y"+py+" Z"+pz+" F"+pf );
  }
  
  // Finishing
  output.println("M103");          // Turn ALL extruder off.
  output.println("M106");          // Fan START
  output.println("M561 P9600 S900");  //Reverse extruder 1. Parameter P= stepper steps, S= RPM * 10
  output.println("M104 S140");     // Extruder 1 temperature 140 degC
  output.println("M542");  //Enter 3000 nozzle wipe / move to RapMan rest location
  output.println("M543");  //Exit 3000 nozzle wipe / does nothing on RapMan
  output.println("M113 S0.0");     //Set Extruder PWM
  //output.println("M107");        // Fan STOP
  
  //closing the output file
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
}



void mouseWheel(MouseEvent event) {// camera distance
  float c = event.getCount();
  if(c>0) magnify+=0.05;
   else  magnify-=0.05;
  distance=DIST_*magnify;
  //println(distance);
}

void keyPressed() {
  if( '1' == key || 'R' == key || 'r' == key )  magnify= 1.0;  // reset 1x camera distance
  if( '2' == key )  magnify= 2.0;  // 2x camera distance 
  if( '3' == key )  magnify= 3.0;  // 3x camera distance 
  if( '5' == key )  magnify= 0.5;  // 0.5x camera distance
  if( 'S'== key || 's'== key || 'W'== key || 'w'== key )  writeBFB();  // output 3D printing file for RapMan3.1
  distance=DIST_*magnify;
  //println(key);
}