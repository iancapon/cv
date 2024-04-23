PImage mapa;
PImage nubes;
PImage esfera;
int res=2;
int wid=2048;
int hei=1024;
void setup() {
  size(720, 720);
  mapa= loadImage("2k_earth_daymap.jpg");
  //nubes= loadImage("2k_moon.jpg");
  esfera=createImage(180*res, 180*res, RGB);
}
float lonSt=0;
int a=0;
int b=0;
int c=0;
int r=90;

PVector cam=new PVector(0,1,0);
void draw() {
  scale(2);
  noStroke();
  esfera.loadPixels();
  for (float lat=0; lat<180; lat+=0.3) {
    for (float lon=lonSt; lon<lonSt+360; lon+=0.5) {

      //float x=(90*(1- sqrt(cos(abs(radians(90-lat))))*sin(radians(90-lonSt+lon))));
      //float y=lat;
      float x=sin(radians(lat))*cos(radians(lonSt+lon));
      float y=sin(radians(lat))*sin(radians(lonSt+lon));
      float z=cos(radians(lat));

      //PVector pos=new PVector(x,y,z);//
      PVector pos=rot(x,y,z,radians(a),radians(b),radians(c));
      if(pos.y>0){//if(pos.dist(cam)<sqrt(2)){
        //ector canv=new PVector(-pos.x*r*res,-pos.z*r*res);//proy(pos,r*res);
        int value=floor(-pos.x*r*res+r*res)+floor(-pos.z*r*res+r*res)*180*res;

        PVector pixel=peters(new PVector(lon, lat));
        int pix=int(pixel.x)+int(pixel.y)*wid;
        if (pix>=wid*hei) {pix=0;}
        if(pix<0){pix=wid*hei-1;}
        if (value>=180*180*res*res) {value=0;}
        if(value<0){value=180*180*res*res-2;}
      
      esfera.pixels[value]=color(mapa.pixels[pix],255);
      esfera.pixels[value+1]=color(mapa.pixels[pix],255);
      //esfera.pixels[value+180*res]=color(mapa.pixels[pix],255);
      //esfera.pixels[value+180*res-1]=color(mapa.pixels[pix],255);
        //fill(color(mapa.pixels[pix],255));
        //ellipse(canv.x+r*res*2,canv.y+r*res*2,5,5);
      }
    }
  }
  esfera.updatePixels();
  image(esfera,0,0);
  lonSt++;
}

void keyPressed(){
if (key==CODED){
if (keyCode==UP){c++;}
if (keyCode==DOWN){c--;}
if (keyCode==LEFT){a++;}
if (keyCode==RIGHT){a--;}
}
}

PVector proy(PVector p,int s) {
    PVector x=new PVector(cos(2*PI/3)*p.x*s, sin(2*PI/3)*p.x*s);
    PVector y=new PVector(cos(4*PI/3)*p.y*s, sin(4*PI/3)*p.y*s);
    PVector z=new PVector(cos(6*PI/3)*p.z*s, sin(6*PI/3)*p.z*s);

    PVector xy=new PVector(x.x+y.x, x.y+y.y);
    PVector xyz=new PVector(xy.x+z.x, xy.y+z.y);

    //ellipse(xyz.x,xyz.y,5,5);
    return xyz;
  }
  PVector rot(float x, float y, float z, float a, float b, float c) {
    float xx=cos(a)*cos(b)*x; //+
    float xy=(cos(a)*sin(b)*sin(c)-sin(a)*cos(c))*y;// +
    float xz=(cos(a)*sin(b)*cos(c) + sin(a)*sin(c))*z;

    float yx=sin(a)*cos(b)*x;
    float yy=(sin(a)*sin(b)*sin(c)+cos(a)*cos(c))*y;
    float yz=(sin(a)*sin(b)*cos(c)-cos(a)*sin(c))*z;

    float zx=-sin(b)*x;
    float zy=cos(b)*sin(c)*y;
    float zz=cos(b)*cos(c)*z;

    PVector r=new PVector(xx+xy+xz, yx+yy+yz, zx+zy+zz);
    return r;
    
  }


PVector peters(PVector degrees) {//recibe en grados
  float x=(degrees.x)*wid/360;
  float y=(degrees.y)*hei/180;
  return new PVector(x, y);//devuelve pixel en mapa
}
