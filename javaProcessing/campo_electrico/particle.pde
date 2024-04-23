public class particle{
float x,y,m,vx,vy,cx,cy,G;
PVector campo;
  public particle(float x_,float y_){
    cx=0;
    cy=0;
    vx=0;
    vy=0;
    x=x_;
    y=y_;
    m=1;
    G=-10;
  }
  
  void arrow(){
    float len=sqrt(cx*cx+cy*cy);
    if (len==0)len=1;
    line(x,y,x+ 10*cx/len,y+ 10*cy/len);
    ellipse(x,y,2,2);
  }
  
  void refresh(){
    vx+=cx;
    vy+=cy;
    x+=vx;
    y+=vy;
    fill(255,0,0);
    if(m<0)fill(0,0,255);
    ellipse(x,y,abs(m)*10,abs(m)*10);
  }
  void superpose(particle[]array,int len){  
    this.cx=0;
    this.cy=0;
    for (int i=0; i< len; i++){
      float dist=sqrt(pow(this.x-array[i].x,2)+pow(this.y-array[i].y,2));
      if(dist>(abs(this.m)+abs(array[i].m))*5){
        float campo=-G*this.m*array[i].m/pow(dist,2);//en realidad es fuerza, pero guueno.
        cx+= campo*(this.x-array[i].x);
        cy+= campo*(this.y-array[i].y);
      }
        
    }
      
  }
}
