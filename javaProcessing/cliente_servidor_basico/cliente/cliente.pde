import processing.net.*;
Client cliente;
void setup(){
  size(500,500);
  cliente=new Client(this,"192.168.0.185",9999);
}
char turn=0;
void draw(){
  background(0);
  byte[]byteArray={1,2,2,3,(byte)turn,-1};
  if(cliente.active() && turn==0){
    background(255,0,0);
    cliente.write(byteArray);
    turn++;
  }
  
}
