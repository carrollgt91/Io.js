
FlowerOfLife flower;
ArrayList lines;
EqualateralTri outerTriangle;
EqualateralTri centerTriangle;
EqualateralTri innerTriangle;
bool isDrawingLines;
void setup()
{
  isDrawingLines = false;
  size(800,800);
  background(255);
  fill(0);
  stroke (255);
  loop();
  PFont fontA = loadFont("courier");
  textFont(fontA, 14);  
  radius = 100;
  centerY = 400;
  lines = new ArrayList();
  flower = new FlowerOfLife(400, 400, radius);
  for (int i = 0; i<6; i++) {
    Circle cir = (Circle) flower.circles.get(i);
    Line li = new Line(cir.x, cir.y, cir.x + radius*cos(radians(60*i)), cir.y + radius*sin(radians(60*i)), .1);
    lines.add(li);
}
x1 = cos(radians(210))*radius;
x2 = cos(radians(330))*radius;
botSideLength = abs(x2-x1);
outerTriangle = new EqualateralTri(400, centerY - radius - 100, botSideLength + 180);
centerTriangle = new EqualateralTri(400, centerY - radius, botSideLength);
innerTriangle = new EqualateralTri(400, centerY - radius + 35, botSideLength-60);
}

void draw(){  
  fill(255);
  rect(20, 20, 760, 760);

  stroke(0);
  strokeWeight(8);
  outerTriangle.animate();
  fill(255, 255, 255, 0);
  flower.drawFlower();
  fill(255);
  centerTriangle.animate();
  innerTriangle.animate();


  drawIoLines();

}

void drawIoLines()
{
  if(isDrawingLines)
  {
      for (int i = 0; i<6; i++) {
          Line li = (Lines)lines.get(i);
          li.drawLineLoop();
      }
  }
} 

void mouseClicked() {
  flower.isAnimating = true;
  println("flower");
}


class Circle{
  float x, y, radius, currentDegree;
  int strokeVal;
  Circle(float cx, float cy, float radLength){
    this.x = cx;
    this.y = cy;
    currentDegree = 0;
    this.radius = radLength;
    strokeVal = 0;  
}

void drawCircle()
{

    ellipse(this.x, this.y, this.radius*2,this.radius*2);
}

void drawCircleLoop()
{

    arc(this.x, this.y, (this.radius)*2, (this.radius)*2, 0, radians(this.currentDegree));
    this.update();
}

void drawCircleLoop(float startingDegrees)
{

    arc(this.x, this.y, (this.radius)*2, (this.radius)*2, radians(startingDegrees), radians(startingDegrees + currentDegree));
    this.update();
    
}

void update()
{
    degreeIteration = 6;
    float newDegree;
    newDegree = ((this.currentDegree + degreeIteration)%720);
    if(newDegree == 360)
    {
      newDegree = 6;
      flower.isAnimating = false;
      isDrawingLines = true;
    }
  this.currentDegree = newDegree;
}

}

class Point
{
  float x, y;

  Point(float xP, float yP){
    this.x = xP;
    this.y = yP;
}
}




class FlowerOfLife { 
  float cx, cy, radius;
  ArrayList circles; 
  Circle center;
  bool isAnimating;
  FlowerOfLife(float centerX, float centerY, float radiusLength) {  
    cx = centerX; 
    cy = centerY; 
    center = new Circle(cx, cy, this.radius);
    circles = new ArrayList();
    radius = radiusLength;
    this.generatePoints();
    isAnimating = true;
} 


void generatePoints() { 

   int i = 0;
   while (i < 6)
   {
      deg = i*60+30;
      nx = cos(radians(deg))*radius + cx;
      ny = sin(radians(deg))*radius + cy;


      Circle circle = new Circle(nx,ny, radius);

      circles.add(circle);
      i++;
  }

} 
void drawFlower()
{
  Circle center = new Circle(cx, cy, this.radius);
  center.drawCircle();

  for (int i = 0; i < 6;i++) {
    Circle fl = (Circle)circles.get(i);
    if(isAnimating)
        fl.drawCircleLoop(60*i + 210);
    else fl.drawCircle();
}
}
}

/*
class Line { 
  float x1, y1, x2, y2, delta;
  float dx, dy;
  Line(float x1i, float y1i,float x2i, float y2i){
    println("Constructor");
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

    if (((x2 < 30.0)||(x2 > 770.0) || (y2 > 770.0) || (y2<30.0))|| (abs(x2-x1)<20 && x2-x1!=0) || (abs(y2-y1)<20 && y2-y1!=0)) {
      delta = -delta;
    }
    
  }
}
*/

class EqualateralTri extends Animation{ 
  float x, y, sideLength, height, x1, y1, x2, y2, delta; 
  AnimationList lines;
  EqualateralTri(float xTop, float yTop, float botSideLength) {  
    x = xTop; 
    y = yTop; 
    sideLength = botSideLength;
    height = sqrt((pow(sideLength,2) - pow((sideLength/2),2)));
    this.delta = .01;
    lines = new AnimationList();
    this.generatePoints();
    this.generateLines();
} 

void startAnimation()
{
  this.isAnimating = true;
}
void animate()
{

if(((mouseX < this.x + .55*this.sideLength)&& (mouseY < this.y + 1.1*height)) && ((mouseX > this.x - .55* sideLength) && (mouseY > this.y - .1*height)))
{
      this.startAnimation();
}
else
{
      this.stopAnimation();
 }


if(this.isAnimating)
    this.animateTriangle();
else
    this.draw();
}
void stopAnimation()
{
  this.isAnimating = false;
}
void draw()
{
  this.drawTriangle();
}


void generatePoints() { 

   x1 = x - (sideLength/2);
   x2 = x1 + sideLength;
   y1 = y2 = y + height;
} 

void generateLines() {

    Line newLine = new Line(x,y, x1, y1, this.delta);
    this.lines.list.add(newLine);
    Line newLine1 = new Line(x1,y1, x2, y2, this.delta);
    this.lines.list.add(newLine1);
    Line newLine2 = new Line(x2,y2, x, y, this.delta);
    this.lines.list.add(newLine2);
}
void drawTriangle()
{
    triangle(x,y,x1,y1,x2,y2);
}
void animateTriangle()
{
    for (int i = 0; i<3; i++) {
      Line aLine = (Line)this.lines.list.get(i);
      aLine.startAnimation();
      aLine.animate();
  }
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

  AnimationList()
  {
    list = new ArrayList();
}
AnimationList(Animation startAnimation)
{
    list = new ArrayList();
    this.currentAnimation = startAnimation;
    this.currentAnimation.list=this;
    list.add(this.currentAnimation);
}

void add(Animation animation)
{
    if(!this.currentAnimation)
    {
      this.currentAnimation = animation;
  }
  animation.list = this;
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
      currentIndex = 0;
  }
  this.currentAnimation = list.get(currentIndex);
  return this.currentAnimation;
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
    xlim = 2*abs(delta*this.dx);
    ylim = 2*abs(delta*this.dy);

}
void startAnimation()
{
  this.isAnimating = true;
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
      //println("<20");
      //this.stopAnimation();
      this.cx2 = this.x1 + (delta*this.dx);
      this.cy2 = this.y1 + (delta*this.dy);
  }
}
}
