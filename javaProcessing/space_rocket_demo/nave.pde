class nave {
  float x,y,u,v,G;
  pointMass obj;
  public nave(float x, float y,float G) {
    this.x=x;
    this.y=y;
    obj=new pointMass(x,y,1,2,G);
  }
  
  
}
