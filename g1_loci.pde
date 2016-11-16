
public class g1_loci extends PVector {
  
  //Field
  public float feed;
  
  //Constructor
  
  g1_loci(float x_, float y_, float z_, float feed_) {// new constructor
    x= x_;
    y= y_;
    z= z_;
    feed= feed_;
  }
  //Methods
  public float[]  get(float[] target) {
    target[0]= x;
    target[1]= y;
    target[2]= z;
    target[3]= feed;
    return target;
  }
  public g1_loci  set(float[] source) {
    x= source[0];
    y= source[1];
    z= source[2];
    feed= source[3];
    return this;
  }
  
  public g1_loci add(PVector v) {  //translation of the x,y,z data
    super.add(v);
    return this;
  }
  
  public String toString() {
     float px= round(x *1000.0)/1000.0;
     float py= round(y *1000.0)/1000.0;
     float pz= round(z *1000.0)/1000.0;
     float pf= round(feed *10.0)/10.0;
     //output.println("G1 X"+lx+" Y"+ly+" Z"+lz+" F"+pf);
    return "G1 X"+px+" Y"+py+" Z"+pz+" F"+pf;
  }
  
  public String toStringTranslated(float cx, float cy, float cz) {
     float px= round((x+cx) *1000.0)/1000.0;
     float py= round((y+cy) *1000.0)/1000.0;
     float pz= round((z+cz) *1000.0)/1000.0;
     float pf= round(feed *10.0)/10.0;
     //output.println("G1 X"+lx+" Y"+ly+" Z"+lz+" F"+pf);
    return "G1 X"+px+" Y"+py+" Z"+pz+" F"+pf;
  }
  
  
}//end of class