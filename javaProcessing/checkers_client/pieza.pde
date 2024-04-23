class pieza {
  int x, y, team, index, value;//team 0:rojo, 1:blanco; value 0:empty, 1:full
  int pick;//0 unpick, 1 pick,
  public pieza(int x, int y, int team, int index, int value) {
    this.x=x;
    this.y=y;
    this.team=team;
    pick=0;
    this.index=index;
    this.value=value;
  }
  void show() {
    if (value>0) {
      if (pick==0) {
        fill(255, 255*team, 255*team);
      }
      if (pick==1) {
        fill(200);
      }
      if (value==2) {
        fill(255, 255*team, 255*team);
        ellipse(x*80-5+40, y*80-5+40, 70, 70);
        ellipse(x*80-5+40, y*80-5+40, 50, 50);
      }
      ellipse(x*80+40, y*80+40, 70, 70);
      ellipse(x*80+40, y*80+40, 50, 50);
    }
  }
  
  void reset(){
    pick=0;
    value=0;
  }
}
