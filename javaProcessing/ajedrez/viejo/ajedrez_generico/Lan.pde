String myIp="0.0.0.0";
int myPort=9999;
///////////////////////////
String otherIp="0.0.0.0";
int otherPort=9999;
///////////////////////////
Server myServer;
Client myClient;
Client otherClient;
byte[]dataInpBuffer=new byte[3];//[0]:piece@position [1]:movesTo. [2]:-1
byte[]dataOutBuffer=new byte[3];
boolean notYetConnected=true;

boolean initClient() {
  for (int i=0; i<2; i++) {
    dataInpBuffer[i]=(byte)-1;
    dataOutBuffer[i]=(byte)-1;
  }
  dataInpBuffer[2]=(byte)0;
  dataOutBuffer[2]=(byte)0;
  myClient=new Client(this, otherIp, otherPort);
  if (myClient.active()) {
    println("servidor encontrado, conectado en- ip:"+otherIp+" ; puerto:"+otherPort);
    dataOutBuffer[0]=100;//,0,0};
    //writeOutData();
  } else
    println("servidor no encontrado");
  return myClient.active();
}
void initServer() {
  myServer=new Server(this, myPort, myIp);
  myClient=myServer.available();
  println("servidor abierto- ip:"+myIp+" ; puerto:"+myPort);
}
int readIncomingData() {
  int byteCount=0;
  if (team==1) {
    myClient=myServer.available();
    if (myClient!=null) {
      byteCount= myClient.readBytes(dataInpBuffer);
      println("incomingData:"+(int)dataInpBuffer[0]+" : "+(int)dataInpBuffer[1]+" : "+(int)dataInpBuffer[2]);
    }
  }
  if (team==0) {
    if (myClient.available()>0) {
      byteCount= myClient.readBytes(dataInpBuffer);
      println("incomingData:"+(int)dataInpBuffer[0]+" : "+(int)dataInpBuffer[1]+" : "+(int)dataInpBuffer[2]);
    }
  }
  return byteCount;
}
void writeOutData() {
  if (team==1) {
    myServer.write(dataOutBuffer);///si soy servidor
  }
  if (team==0) {
    myClient.write(dataOutBuffer);///si soy cliente
  }
  println("sending data:"+(int)dataOutBuffer[0]+" : "+(int)dataOutBuffer[1]);
}
