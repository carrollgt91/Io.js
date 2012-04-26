static int FRAMERATE = 30;
 FlowerOfLife flower;
 AnimationList animations;

void setup()
{
  size(800,800);
  background(255);
  fill(0);
  stroke (255);
  loop();
  frameRate(FRAMERATE);
  PFont fontA = loadFont("courier");
  textFont(fontA, 14);  
  Circle circle = new Circle(400,400, 200);

  //animations = new AnimationList();
  flower = new FlowerOfLife(circle.x, circle.y, circle.radius);
  flower.startAnimation();

}

void draw(){  
  
  radius = 100;
  
  fill(255);
  stroke(0);
  strokeWeight(8);
  rect(20, 20, 760, 760);

  //Circle cir = (Circle)animations.list.get(0);
  //cir.animate();
  fill(255, 255, 255, 0);
 
  flower.animate();
  



}

class EqualateralTri { 
  float x, y, sideLength, height, x1, y1, x2, y2; 
  EqualateralTri(float xTop, float yTop, float botSideLength) {  
    x = xTop; 
    y = yTop; 
    sideLength = botSideLength;
    height = sqrt((pow(sideLength,2) - pow((sideLength/2),2)));
    this.generatePoints();
  } 

  
  void generatePoints() { 

     x1 = x - (sideLength/2);
     x2 = x1 + sideLength;
     y1 = y2 = y + height;
  } 
  void drawTriangle()
  {
    triangle(x,y,x1,y1,x2,y2);
  }
}


class Circle extends Animation{
  float x, y, radius, currentDegree, currentRadian;
  int strokeVal;
  float doubleRadius;
  Circle(float cx, float cy, float radLength){
    this.x = cx;
    this.y = cy;
    currentDegree = 0;
    currentRadian = 0;
    this.radius = radLength;
    doubleRadius = this.radius*2;
    this.isDrawing = false;
    strokeVal = 0;  
  }

    void startAnimation()
    {
      this.isAnimating = true;
    }
    void animate()
    {
      if(isAnimating)
      {
        this.drawCircleLoop2(0);
      }
      else
      {
        this.drawCircle();
      }
    }
    void stopAnimation()
    {
      this.isAnimating = false;
      //Animation nAnimation = (Animation)this.list.nextAnimation();
      //nAnimation.startAnimation();
      this.isDrawing = true;
    }
    void draw()
    {
      if(this.isDrawing)
        this.drawCircle();
    }

  void drawCircle()
  {

    ellipse(this.x, this.y, doubleRadius,doubleRadius);
  }

  void drawCircleLoop()
  {
    arc(this.x, this.y, doubleRadius, doubleRadius, 0, radians(this.currentDegree));
    this.update();
  }

    void drawCircleLoop(float startingDegrees)
  {

    arc(this.x, this.y, doubleRadius, doubleRadius, radians(startingDegrees), radians(startingDegrees + currentDegree));
    this.update();
    
  }

    void drawCircleLoop2(float startingRadian)
  {

    arc(this.x, this.y, doubleRadius, doubleRadius, startingRadian, startingRadian + currentRadian);
    this.update2();
    
  }

  void update()
  {
    degreeIteration = 6;
    float newDegree;
    newDegree = ((this.currentDegree + degreeIteration)%560);
    if(newDegree == 360)
    {
      flower.isAnimating = false;
      //isDrawingLines = true;

    }
    this.currentDegree = newDegree;
  }

void update2()
  {
    float radianIteration = radians(6);
    float newRadian;
    newRadian = this.currentRadian + radianIteration;
    if(newRadian >= TWO_PI)
    {
      println("update2");
      this.stopAnimation();
      println("stopAnimation");
      //Animation nAnimation = (Animation) this.list.nextAnimation();
      println("nextAnimation");
      //nAnimation.startAnimation();
      isDrawing = true;
      newRadian = 0;

    }
    this.currentRadian = newRadian;
  }
  
}

class FlowerOfLife extends Animation { 
  float cx, cy, radius;
  AnimationList circles; 
  Circle center;
  bool isAnimating;
  FlowerOfLife(float centerX, float centerY, float radiusLength) {  
    cx = centerX; 
    cy = centerY; 
    center = new Circle(cx, cy, this.radius);
    circles = new AnimationList();
    radius = radiusLength;
    this.generatePoints();
    println("constructor Over");
    Circle aCircle = (Circle) circles.list.get(0);
    aCircle.startAnimation();
    isAnimating = true;
    
  } 

    void startAnimation()
    {
      this.isAnimating = YES;
    }
    void animate()
    {
      if(this.isAnimating)
      {
        this.animateFlower();
      }
      else
      {
        this.draw();
      }
    }
    void stopAnimation()
    {
      this.isAnimating = NO;
    }
    void draw()
    {
      this.drawFlower2();
    }
  
  void generatePoints() { 

     int i = 0;
     while (i < 6)
     {
      deg = i*60+30;
      nx = cos(radians(deg))*radius + cx;
      ny = sin(radians(deg))*radius + cy;


      Circle circle = new Circle(nx,ny, radius);
      circles.list.add(circle);
      AnimationList aList = (AnimationList) circle.animList;
      println("circle list size:";
      i++;
     }

  } 
  void drawFlower()
  {
      Circle center = new Circle(cx, cy, this.radius);
      center.drawCircle();
      
      for (int i = 0; i < 6;i++) {
        Circle fl = (Circle)circles.list.get(i);
        if(isAnimating)
        fl.drawCircleLoop(60*i + 180);
      else fl.drawCircle();
      }
      
  }

  void drawFlower2()
  {
      Circle center = new Circle(cx, cy, this.radius);
      center.drawCircle();
      
      for (int i = 0; i < 6;i++) {
        Circle fl = (Circle)circles.list.get(i);
       fl.drawCircle();
      }
      
  }

  void animateFlower()
  {
      Circle center = new Circle(cx, cy, this.radius);
      center.drawCircle();
      
      for (int i = 0; i < 6;i++) {
        Circle fl = (Circle)circles.list.get(i);
          fl.animate();
      }
      
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
  { //outdated
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
      println("loop restart");
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
   this.isAnimating = true;
   for(int it = 0; it < this.list.size(); it ++)
      {
        //println("list startAnimation loop");
        Animation anim = (Animation) this.list.get(it);
        anim.isDrawing = false;
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
        this.animList.startNextAnimation();
      }
      else
      {

      }
  }

  void stopDrawing()
  {
    for(int i = 0; i < this.list.size(); i ++)
      {
        Animation anim = (Animation) this.list.get(i);
        anim.isDrawing = false;
      }
  } 

  void startNextAnimation()
  {
    Animation neAnimation = (Animation)this.nextAnimation();
    neAnimation.startAnimation();
  }

}