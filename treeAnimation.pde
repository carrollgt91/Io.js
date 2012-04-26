//Line aLine;
//Tree aTree;

void setup()
{
  size(800,800);
  background(255);
  fill(0);
  stroke (255);
  loop();
  PFont fontA = loadFont("courier");
  //aLine = new Line(400, 400, 300, 100, .05);
  textFont(fontA, 14); 
  //aTree = new Tree(100, .5, .5, 200, 200); 
}

void draw(){  
  fill(255);
  stroke(0);
  strokeWeight(10);
  rect(20, 20, 760, 760);
  //aTree.drawTree();
}

/*
class Point
{
  float x, y;

  Point(float xP, float yP){
    this.x = xP;
    this.y = yP;
  }
}

class Node
{
  float x, y;
  ArrayList nextGeneration;

  Node(float x, float y)
  {
    this.x = x;
    this.y = y;
    this.segLegth = segLegth;
  } 
}

class Tree {
  float segLength, xDir, yDir, x, y; //xDir and yDir form a unit vector in the direction of the tree
  ArrayList nodes;
  Tree(float length, float xDirection, float yDirection, float x, float y){
  this.segLength = length;
  this.xDir = xDirection;
  this.yDir = yDirection;
  this.x = x;
  this.y = y;
  this.nodes = new ArrayList();

  println("Tree Constructor");

  float xN, yN;
  xN = x + segLength*xDirection;
  yN = y + segLength*yDirection;
  Node node = new Node(xN, yN);
  nodes.add(node);

    
  }
}

void generatePointsForUniformTree(Node node){

}

void drawTree{
  Node firstNode = (Node)nodes.get(0);
  line(this.x, this.y, firstNode.x, firstNode.y);

}

}

class Line { 
  float x1, y1, x2, y2, delta;
  float dx, dy;
  Line(float x1i, float y1i,float x2i, float y2i){
    this.x1 = x1i; 
    this.x2 = x2i; 
    this.y1 = y1i; 
    this.y2 = y2i;
    this.dx = x2 - x1;
    this.dy = y2 - y1;
    delta = .01;
  }


  Line(float x1, float y1,float x2, float y2, float delta) {  
    this.x1 = x1; 
    this.x2 = x2; 
    this.y1 = y1; 
    this.y2 = y2;
    this.dx = x2 - x1;
    this.dy = y2 - y1;
    this.delta = delta;

  } 
  void drawLine() { 
    line(this.x1, this.y1, this.x2, this.y2);   
  }
 
  void drawLineLoop(){
    //println("loop");
    line(this.x1, this.y1, this.x2, this.y2);
    this.update();
  }

  void update(){
   // println("update");
    this.x2 = this.x2 + (delta*this.dx);
    this.y2 = this.y2 + (delta*this.dy);

    if (((x2 < 30.0)||(x2 > 770.0) || (y2 > 770.0) || (y2<30.0))||(abs(x2-x1)<5 || abs(y2-y1)<5)) {
      delta = -delta;
    }
    
  }
}

