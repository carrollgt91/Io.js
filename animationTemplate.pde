


EqualateralTri outerTriangle;

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
  animations = new AnimationList();
  outerTriangle = new EqualateralTri(400, 400, 300);
  animations.add(outerTriangle);
  //animations = new AnimationList();
  


}

void draw(){  
  
  radius = 100;
  
  fill(255);
  stroke(0);
  strokeWeight(8);
  rect(20, 20, 760, 760);
  //outerTriangle.drawTriangle();
  Animation animation = (Animation)animations.currentAnimation;
  if((mouseX < 700 && mouseY < 700) && (mouseX > 150 && mouseY > 400))
  {
    animation.startAnimation();
  }
  else
  {
    animation.stopAnimation();
  }
  animation.animate();

  fill(255, 255, 255, 0);


}

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
