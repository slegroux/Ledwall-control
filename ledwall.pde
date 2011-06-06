import processing.opengl.*;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
int row=9;
int col=9;

Cell[][] grid;
int [][] myArray=new int[row][col];

void setup(){
  size(200,200);
   frameRate(30);
  oscP5=new OscP5(this,1234);
  grid =new Cell[col][row];
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < row; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*20,j*20,20,20,i+j);
    }
  }
}

void draw(){
  background(0);
  for (int i=0;i<col;i++){
    for (int j=0;j<row;j++)
    {
      //grid[i][j].oscillate();
      grid[i][j].display(myArray[i][j]);

    }
  }
 
  println();
}

void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  if(theOscMessage.checkAddrPattern("/r")==true) {
    /* check if the typetag is the right one. */
    //if(theOscMessage.checkTypetag("ifs")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      for (int i=0;i<col;i++){
        for (int j=0;j<row;j++)
        {
          myArray[i][j]=theOscMessage.get(i+j*col).intValue();
          }
        }
      
      return;
   // }  
  } 
  //println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}

class Cell {
  // A cell object knows about its location in the grid as well as its size with the variables x,y,w,h.
  float x,y;   // x,y location
  float w,h;   // width and height
  float angle; // angle for oscillating brightness

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, float tempAngle) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    angle = tempAngle;
  } 
  
  // Oscillation means increase angle
  void oscillate() {
    angle += 0.02; 
  }

  void display(int cell_color) {
    stroke(255);
    // Color calculated using sine wave
    fill(cell_color);
    //fill(127+127*sin(angle));
    rect(x,y,w,h); 
  }
}

