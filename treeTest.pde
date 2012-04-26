AnimationList animations;
AnimationList subAnimations;
Line aLine;
Tree aTree;
void setup()
{
  size(800,800);
  background(255);
  fill(0);
  stroke (255);
  loop();
  PFont fontA = loadFont("courier");
  textFont(fontA, 14);
  animations = new AnimationList();
  subAnimations = new AnimationList();
  aLine = new Line(100, 100, 200, 200, .05);
  aLine.startAnimation();
  animations.add(aLine);

  Line rLine0 = new Line(200, 200, 300, 200, .05);
  rLine0.startAnimation();
  subAnimations.add(rLine0);

  Line rLine1 = new Line(200, 200, 300, 300, .05);
  rLine1.startAnimation();
  subAnimations.add(rLine1);

  Line rLine2 = new Line(200, 200, 200, 400, .05);
  rLine2.startAnimation();
  subAnimations.add(rLine2);
  animations.add(subAnimations);

  tree = new Tree(100, 10, 200, 200, 45);
  for (int i = 0; i < tree.generations.size();i++) {
    AnimationList generationList = tree.generations.get(i);
    println("generationList size in setup:" + generationList.size());
  }
  AnimationList anLi = (AnimationList)tree.generations.get(0);
  anLi.startAnimation();
  println("anLi size:" + anLi.size());
  tree.startAnimation();
}

void draw(){  
  radius = 100;
  fill(255);
  stroke(0);
  strokeWeight(4);
  rect(20, 20, 760, 760);
  fill(255, 255, 255, 0);
/*
  for(int i = 0; i < animations.list.size(); i ++)
  {
    Animation animation = animations.get(i);
    animation.animate();
  }
*/ 
  tree.animate();
  //aLine.animate();
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
    //println("deltax:" + abs(delta*this.dx) + "deltay:" + abs(delta*this.dy));
    xlim = 2*abs(delta*this.dx);
    ylim = 2*abs(delta*this.dy);
    //println("xlim:" + xlim + ", ylim: " + ylim);

  }
      void startAnimation()
    {
      this.isAnimating = true;
      //println("lineStartAnimation");
    }
    void animate()
    {
      if(this.isAnimating)
        {
          //println("lineAnimate");
          this.drawLineLoop2();
        }
    else
    {this.draw();}
    }
    void stopAnimation()
    {
      this.isAnimating = false;
      this.isDrawing = true;
      if(this.animList.list.indexOf(this) == (this.animList.size()-1))
      {
        this.animList.stopAnimation();
        //println("animListStop");
      }
    }
    void draw()
    {
      if(this.isDrawing)
      {
        this.drawLine();
        //println("x1:" + this.x1 + "y1:" + this.y1 + "x2:" + this.x2 + "y2:" + this.y2);
      }
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
      //println("<20");
      //weirdness is here; this is what's causing the problem. Not sure why the print statement 
      this.cx2 = this.x1 + (delta*this.dx);
      this.cy2 = this.y1 + (delta*this.dy);
      //println("this.cx2:" + this.cx2);
      this.stopAnimation();
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
  float segLength, theta, x, y, branchTheta; 
  ArrayList nodes;
  AnimationList generations;
  int maxGenerations;

  //length of a segment, theta in degrees for the angle from the origin (measured clockwise with the first quadrant being lower right)
  //initial x xV, initial y yV
  Tree(float length, float theta, float xV, float yV, float branchTheta){
  this.segLength = length;
  this.theta = theta;
  this.x = xV;
  this.y = yV;
  this.nodes = new ArrayList();
  this.maxGenerations = 4;
  this.branchTheta = branchTheta;
  float xN;
  float yN;
  xN = x + segLength*cos(radians(theta));
  yN = y + segLength*sin(radians(theta));
  Node node = new Node(xN, yN, 0);
  nodes.add(node);
  this.generations = new AnimationList();
  this.generations.startAnimation();
  for(int i = 0; i < this.maxGenerations; i++)
    {
      AnimationList generationList = new AnimationList();
      generations.add(generationList);
    }
    //println("generations size: " + generations.size());

    this.generatePointsForUniformTree(node);
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
    //println("treeAnimate calling generationsAnimate");
    this.generations.animate();
  }
  else
  {
    this.generations.draw();
  }
}
void endAnimation()
{
  this.isAnimating = false;
}

void generatePointsForUniformTree(Node node){
  int gen = node.generation + 1;
  AnimationList generationList = (AnimationList)this.generations.get(gen-1);
  float x1, y1;
  x1 = node.x + segLength*(cos(radians(theta - branchTheta)));
  y1 = node.y + segLength*(sin(radians(theta - branchTheta)));
  Node leftNode = new Node(x1,y1, gen);
  Line leftLine = new Line(node.x, node.y, leftNode.x, leftNode.y, .01);
  generationList.add(leftLine);


  if(leftNode.generation < maxGenerations)
  {
    this.generatePointsForUniformTree(leftNode);
  }

  float x2, y2;
  x2 = node.x + segLength*(cos(radians(theta)));
  y2 = node.y + segLength*(sin(radians(theta)));
  Node centerNode = new Node(x2,y2, gen);
  Line centerLine = new Line(node.x, node.y, centerNode.x, centerNode.y, .01);
  generationList.add(centerLine);
  if(centerNode.generation < maxGenerations)
  {
    this.generatePointsForUniformTree(centerNode);
  }


  float x3, y3;
  x3 = node.x + segLength*(cos(radians(theta + branchTheta)));
  y3 = node.y + segLength*(sin(radians(theta + branchTheta)));
  Node rightNode = new Node(x3,y3, gen);
  Line rightLine = new Line(node.x, node.y, rightNode.x, rightNode.y, .01);
  generationList.add(rightLine);

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
    bool isDrawing;
    AnimationList animList;

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

class AnimationList extends Animation
{
  ArrayList list;
  Animation currentAnimation;
  int currentIndex;
  int count;
  boolean shouldCheckStopAnimation;

  AnimationList()
  {
    list = new ArrayList();
    this.isDrawing = false;
    this.isAnimating = false;
  }
  AnimationList(Animation startAnimation)
  {
    list = new ArrayList();
    this.currentAnimation = startAnimation;
    this.currentAnimation.animList=this;
    list.add(this.currentAnimation);
    this.isDrawing = false;
    this.isAnimating = false;
    count = 0;
  }

  void add(Animation animation)
  {
    if(!this.currentAnimation)
    {
      this.currentAnimation = animation;
    }
    animation.animList = this;
    list.add(animation);
   
  }

  Animation nextAnimation()
  {
    if(currentIndex < list.size()-1)
    {
      currentIndex = currentIndex + 1;
    }
    else
    {
      //println("loop restart");
      this.stopDrawing();
      currentIndex = 0;
    }
    this.currentAnimation = list.get(currentIndex);
    //println("currentAnimation index:" + currentIndex);
    if(this.animList)
    {
      //println("subAnimList size:" + this.animList.size());
    }
    return this.currentAnimation;
  }

  T get(index i)
  {
    return this.list.get(i);
  }

  int size ()
  {
    return this.list.size();
  }

  void draw()
  {
    if(this.isDrawing)
    {
      for(int i = 0; i < this.list.size(); i ++)
      {
        Animation anim = (Animation) this.list.get(i);
        anim.isDrawing = true;
        anim.draw();
        //println("drawLoop i:" + i);
      }
    }
  }

  void startAnimation()
  {
    //println("animList startAnimation size:" + this.size());
   this.isAnimating = true;
   for(int it = 0; it < this.list.size(); it ++)
      {
        //println("list startAnimation loop count: " + it);
        Animation anim = (Animation) this.list.get(it);
        anim.isDrawing = false;
        anim.isAnimating = true;
        anim.startAnimation();
      }
   
  }
  void animate()
  {
    //println("!isAnimating");
    if(this.shouldCheckStopAnimation)
    {
      //println("checkStopAnimation in animate");
      this.checkStopAnimation();
    }
    if(this.isAnimating)
    {
      //println("list animate");
      for(int i = 0; i < this.list.size(); i ++)
      {
        Animation anim = (Animation) this.list.get(i);
        anim.animate();
      }
    }
    else
    {
      this.draw();
    }
  }
  void stopAnimation()
  {
      this.isAnimating=false;
      this.isDrawing = true;
      //println("isAnimating and animList size:" + this.animList.size());
      if(this.animList)
      { 
        //println("stopAnimation list");
        this.animList.startNextAnimation();
      }
  }

  void stopDrawing()
  {
    for(int i = 0; i < this.list.size(); i ++)
      {
        Animation anim = (Animation) this.list.get(i);
        anim.isDrawing = false;
        anim.isAnimating = false;
      }
  } 

  void startNextAnimation()
  {
    Animation neAnimation = (Animation)this.nextAnimation();
    neAnimation.startAnimation();
  }

}