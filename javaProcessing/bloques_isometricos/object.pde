class object {
  float x, y, z;
  float centerx, centery;
  float posx, posy;
  public object(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
    this.centerx=400;//// unico a esta ventana
    this.centery=400;////
    translate3DtoIso();
  }
  void update(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
    translate3DtoIso();
  }
  void translate3DtoIso() {
    float sen60=0.500;
    float cos60=0.866;
    float lxa, lxb, lya, lyb, lza, lzb;//a=proy x; b=proy y
    lxa=x*cos60;
    lxb=x*sen60;
    lya=-y*cos60;
    lyb=y*sen60;
    lza=0;
    lzb=-z;
    posx=centerx+lxa+lya+lza;
    posy=centery+lxb+lyb+lzb;
  }
}
