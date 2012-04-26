
class Point
{
  float x, y;

  Point(float xP, float yP){
    this.x = xP;
    this.y = yP;
  }
}







void setup()
{
  size(800,800);
  background(255);
  fill(0);
  stroke (255);
  noLoop();
  PFont fontA = loadFont("courier");
  textFont(fontA, 14);  
}

void draw(){  
  
  radius = 150;

  fill(255);
  stroke(0);
  strokeWeight(10);
  rect(20, 20, 560, 560);
  fill(255, 255, 255, 0);
  println("Something");
  x = 300;
  y = 300;
  FlowerOfLife flower = new FlowerOfLife(x,y,150);
  flower.drawFlower();
  fill(255);

  
  x1 = cos(radians(210))*radius;
  x2 = cos(radians(330))*radius;


  


}

class FlowerOfLife { 
  float cx, cy, radius;
  ArrayList centers; 
  FlowerOfLife(float centerX, float centerY, float radiusLength) {  
    println("Center x:" + centerX + ", Center y: " + centerY);
    cx = centerX; 
    cy = centerY; 
    centers = new ArrayList();
    radius = radiusLength;
    this.generatePoints();
    println("Constructor cx:" + cx + ", cy:" + cy);
  } 

  
  void generatePoints() { 

     int i = 0;
     while (i < 6)
     {
      deg = i*60;
      nx = cos(radians(deg))*radius + cx;
      ny = sin(radians(deg))*radius + cy;


      Point point = new Point(nx,ny);
      println("generatePoints x:" + point.x + " ,y:" + point.y);
      centers.add(point);
      i++;
     }

  } 
  void drawFlower()
  {
      ellipse(cx, cy, 2*radius, 2*radius);
      
      for (int i = 0; i < 6;i++) {
        Point point = (Point)centers.get(i);
        println("draw flower loop x:" + point.x + " ,y:" + point.y);
        ellipse(point.x,point.y, 2*radius, 2*radius);
      }
      
  }


}

