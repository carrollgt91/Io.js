

Line aLine;
AnimationList animations;

void setup()
{
  size(800,800);
  background(255);
  fill(0);
  stroke (255);
  loop();
  PFont fontA = loadFont("courier");
  textFont(fontA, 14);  
  aLine = new Line(400, 400, 400, 100, .05);
  aLine.startAnimation();
  Line nextLine = new Line(400, 400, 100, 400, .05);
  Line thirdLine = new Line(400, 400, 400, 700, .05);
  Line fourthLine = new Line(400, 400, 700, 400, .05);
  //Tree aTree = new Tree(100, 45, 300, 300);
  animations = new AnimationList(aLine);
  animations.add(nextLine);
  animations.add(thirdLine);
  animations.add(fourthLine);
}

void draw(){  
  
  fill(255);
  stroke(0);
  strokeWeight(10);
  rect(20, 20, 760, 760);
  /*Animation li1 = (Animation) animations.list.get(0);
  li1.animate();
  Animation li2 = (Animation) animations.list.get(1);
  li2.animate();*/
  for (int i = 0; i < animations.list.size(); i ++){
    Animation li = (Animation) animations.list.get(i);
    li.animate(); 
  }
}


class Line extends Animation { 
  float x1, y1, x2, y2, delta;
  float dx, dy;
  float cx2, cy2;
  float xlim, ylim;

  Line(float x1i, float y1i,float x2i, float y2i){
    this.x1 = x1i; 
    this.x2 = x2i; 
    this.y1 = y1i; 
    this.y2 = y2i;
    this.dx = x2 - x1;
    this.dy = y2 - y1;
    this.cx2 = x1;
    this.cy2 = y1;
    delta = .01;

  
  }


  Line(float x1, float y1,float x2, float y2, float delta) {  
    this.x1 = x1; 
    this.x2 = x2; 
    this.y1 = y1; 
    this.y2 = y2;
    this.dx = x2 - x1;
    this.dy = y2 - y1;
    this.cx2 = this.x1 + (delta*this.dx);
    this.cy2 = this.y1 + (delta*this.dy);
    this.delta = delta;
    println("deltax:" + abs(delta*this.dx) + "deltay:" + abs(delta*this.dy));
    xlim = 2*abs(delta*this.dx);
    ylim = 2*abs(delta*this.dy);

  }
      void startAnimation()
    {
      this.isAnimating = true;
      println("startAnimation");
    }
    void animate()
    {
      if(this.isAnimating)
        {
          this.drawLineLoop2();
        }
    else
    {this.drawLine();}
    }
    void stopAnimation()
    {
      this.isAnimating = false;
      Animation nAnimation = this.list.nextAnimation();
      nAnimation.startAnimation();
    }
    void draw()
    {
      this.drawLine();
    }
  void drawLine() { 
    line(this.x1, this.y1, this.x2, this.y2);   
  }
 
  void drawLineLoop(){
    //println("loop");
    line(this.x1, this.y1, this.x2, this.y2);
    this.update();
  }

  void drawLineLoop2(){
    //println("loop");
    line(this.x1, this.y1, this.cx2, this.cy2);
    this.update2();
  }


  void update(){
   // println("update");
    this.x2 = this.x2 + (delta*this.dx);
    this.y2 = this.y2 + (delta*this.dy);
  

    if (((x2 < 30.0)||(x2 > 770.0) || (y2 > 770.0) || (y2<30.0))|| (abs(x2-x1)<20 && x2-x1!=0) || (abs(y2-y1)<20 && y2-y1!=0)) {
      delta = -delta;
    }
  }
    void update2(){
   // println("update");
    this.cx2 = this.cx2 + (delta*this.dx);
    this.cy2 = this.cy2 + (delta*this.dy);
  

    if ((abs(x2-cx2)<xlim && x2-cx2!=0) || (abs(y2-cy2)<ylim)&& y2-cy2!=0) {
      println("<20");
      this.stopAnimation();
      this.cx2 = this.x1 + (delta*this.dx);
      this.cy2 = this.y1 + (delta*this.dy);
    }
  }
}


class Node
{
  float x, y;
  int generation;
  ArrayList nextGeneration;

  Node(float x, float y, int generation)
  {
    this.x = x;
    this.y = y;
    nextGeneration = new ArrayList();
    this.generation = generation;
  } 
  void draw()
  {
    if(!nextGeneration.isEmpty())
    {
      for (int i= 0; i < 3; i++) {
        Node newNode = (Node)nextGeneration.get(i);
        line(this.x, this.y, newNode.x, newNode.y);
        newNode.draw();
      }
    }
  }
}


class Tree extends Animation {
  float segLength, theta, x, y; 
  ArrayList nodes;
  int maxGenerations;
  Tree(float length, float theta, float xV, float yV){
  this.segLength = length;
  this.theta = theta;
  this.x = xV;
  this.y = yV;
  this.nodes = new ArrayList();
  this.maxGenerations = 3;
  float xN;
  float yN;
  xN = x + segLength*cos(radians(theta));
  yN = y + segLength*sin(radians(theta));
  Node node = new Node(xN, yN, 0);
  this.generatePointsForUniformTree(node);
  nodes.add(node);
  }

void draw(){
  this.drawTree();
}
void startAnimation()
{

  this.isAnimating = true;
}
void animate()
{
  if (this.isAnimating) {
  }
  else
  {
    this.draw();
  }
}
void endAnimation()
{
  this.isAnimating = false;
}

void generatePointsForUniformTree(Node node){
  int gen = node.generation + 1;
  float x1, y1;
  x1 = node.x + segLength*(cos(radians(theta - 45)));
  y1 = node.y + segLength*(sin(radians(theta - 45)));
  Node leftNode = new Node(x1,y1, gen);

  if(leftNode.generation < maxGenerations)
  {
    this.generatePointsForUniformTree(leftNode);
  }

  float x2, y2;
  x2 = node.x + segLength*(cos(radians(theta)));
  y2 = node.y + segLength*(sin(radians(theta)));
  Node centerNode = new Node(x2,y2, gen);
  if(centerNode.generation < maxGenerations)
  {
    this.generatePointsForUniformTree(centerNode);
  }


  float x3, y3;
  x3 = node.x + segLength*(cos(radians(theta + 45)));
  y3 = node.y + segLength*(sin(radians(theta + 45)));
  Node rightNode = new Node(x3,y3, gen);

  if(rightNode.generation < maxGenerations)
  {
    this.generatePointsForUniformTree(rightNode);
  }

  node.nextGeneration.add(leftNode);
  node.nextGeneration.add(centerNode);
  node.nextGeneration.add(rightNode);
}

void drawTree(){
 
  Node firstNode = (Node)nodes.get(0);

  line(this.x, this.y, firstNode.x, firstNode.y);
  firstNode.draw();

}

}

class Animation {
    bool isAnimating;
    AnimationList list;

    void startAnimation()
    {
      
    }
    void animate()
    {

    }
    void stopAnimation()
    {

    }
    void draw()
    {

    }
}

class AnimationList
{
  ArrayList list;
  Animation currentAnimation;
  int currentIndex;
  AnimationList(Animation startAnimation)
  {
    println("animationList constructor");
    list = new ArrayList();
    this.currentAnimation = startAnimation;
    this.currentAnimation.list=this;
    list.add(this.currentAnimation);

  }

  void add(Animation animation)
  {
    animation.list = this;
    list.add(animation);
    println("add list size: " + list.size());
  }

  Animation nextAnimation()
  {
    if(currentIndex < list.size()-1)
    {
      currentIndex = currentIndex + 1;
      println("currentIndex + 1:" + currentIndex);
    }
    else
    {
      currentIndex = 0;
      println("reset currentIndex");
    }
    this.currentAnimation = list.get(currentIndex);
    return this.currentAnimation;
  }
}
