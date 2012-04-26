AnimationList animations;
Circle circle;
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

  circle = new Circle(400, 400, 200);
  circle.startAnimation();
  animations.add(circle);
  float cx = 400;
  float cy = 400;
  float radius = 200;
  //generatePoints();
  
    int i = 0;
     while (i < 6)
     {
      int deg = i*60+30;
      float nx = cos(radians(deg))*radius + cx;
      float ny = sin(radians(deg))*radius + cy;
      Circle circle = new Circle(nx,ny, radius);
      //circle.startAnimation();
      animations.add(circle);
      i++;
     }


}

void draw(){  
  
  radius = 100;
  
  fill(255);
  stroke(0);
  strokeWeight(8);
  rect(20, 20, 760, 760);
  fill(255, 255, 255, 0);

  animations.animate();


}


  void generatePoints() { 

     int i = 0;
     while (i < 6)
     {
      deg = i*60+30;
      nx = cos(radians(deg))*radius + cx;
      ny = sin(radians(deg))*radius + cy;
      Circle circle = new Circle(nx,ny, radius);
      animations.add(circle);
      i++;
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
        this.draw();
      }
    }
    void stopAnimation()
    {
      this.isAnimating = false;
      Animation nAnimation = (Animation)this.animList.nextAnimation();
      nAnimation.startAnimation();
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
    float radianIteration = radians(12);
    float newRadian;
    newRadian = this.currentRadian + radianIteration;
    if(newRadian >= TWO_PI)
    {
      println("update2");
      this.stopAnimation();
      println("stopAnimation");
      isDrawing = true;
      newRadian = 0;

    }
    this.currentRadian = newRadian;
  }
  
}




/*
class FlowerOfLife extends Animation { 
  float cx, cy, radius;
  AnimationList circles; 
  Circle center;
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

*/

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
    this.currentAnimation.animList=this;
    list.add(this.currentAnimation);
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
      currentIndex = 0;
    }
    this.currentAnimation = list.get(currentIndex);
    return this.currentAnimation;
  }

  void animate()
  {
    for(int i = 0; i < this.list.size(); i ++)
    {
      Animation anim = (Animation) animations.list.get(i);
      anim.animate();
    }


  }
  T get(index i)
  {
    return this.list.get(i);
  }

  void draw()
  {
    
  }

}

