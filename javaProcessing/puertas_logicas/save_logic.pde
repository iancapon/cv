Table table;
void load_table() {
  table = loadTable("saves/save.csv");
  if (table==null || table.getColumnCount()==0) {
    println("no Saves detected.");
  } else {
    println("Save detected.");
    ////////////////////////////////////
    max=table.getRowCount();
    for (int i=0; i<max; i++) {
      array[i].type=table.getInt(i, 0);
      array[i].x=table.getInt(i, 1);
      array[i].y=table.getInt(i, 2);
      int connCount=table.getInt(i, 3);
      for (int j=0; j<connCount; j++) {
        A=array[i].outlet[0];
        array[table.getInt(i, 4+j*2)].outlet[table.getInt(i, 5+j*2)].coneccion(A);
      }
    }
  }
}

void save_table() {
  Table tabla=new Table();
  for (int k=0; k<12; k++) {
    tabla.addColumn();
    tabla.addColumn();
  }
  for (int i=0; i<max; i++) {
    tabla.addRow();
    tabla.setInt(i, 0, array[i].type);
    tabla.setInt(i, 1, array[i].x);
    tabla.setInt(i, 2, array[i].y);
    tabla.setInt(i, 3, 0);
  }


  for (int i=0; i<max; i++) {
    int p1=array[i].outlet[1].pointer;
    //if (!array[i].outlet[1].connected)p1=0;
    int p2=array[i].outlet[2].pointer;
    //if (!array[i].outlet[2].connected)p2=0;
    int p3=array[i].outlet[3].pointer;

    ////////////////
    if (p1==1) {
      int ni=array[i].outlet[1].conn[0].nodeIndex;
      int oi=array[i].outlet[1].conn[0].outIndex;
      int pi=table.getInt(ni, 3);
      if (oi==0) {
        tabla.setInt(ni, 4+pi*2, i);
        tabla.setInt(ni, 5+pi*2, 1);
        tabla.setInt(ni, 3, pi+1);
      }
    }
    /////////////
    if (p2==1) {
      int ni=array[i].outlet[2].conn[0].nodeIndex;
      int oi=array[i].outlet[2].conn[0].outIndex;
      int pi=table.getInt(ni, 3);
      if (oi==0) {
        tabla.setInt(ni, 4+pi*2, i);
        tabla.setInt(ni, 5+pi*2, 2);
        tabla.setInt(ni, 3, pi+1);
      }
    }
    ////////
    if (p3==1) {
      int ni=array[i].outlet[3].conn[0].nodeIndex;
      int oi=array[i].outlet[3].conn[0].outIndex;
      int pi=table.getInt(ni, 3);
      if (oi==0) {
        tabla.setInt(ni, 4+pi*2, i);
        tabla.setInt(ni, 5+pi*2, 3);
        tabla.setInt(ni, 3, pi+1);
      }
    }
  }
  saveTable(tabla, "saves/save.csv");
  println("saved.");
}
