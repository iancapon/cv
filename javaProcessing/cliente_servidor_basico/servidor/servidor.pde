import processing.net.*;
Server servidor;
void setup(){
  size(500,500);
  servidor=new Server(this,9999,"192.168.0.185");
}

void draw(){
  Client cliente=servidor.available();
  background(0);
  if(cliente!=null){
    background(255);
    String val=cliente.readString();
    println(val);
  }
  
}
