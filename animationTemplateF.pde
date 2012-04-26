
static int FRAMERATE = 30;

void setup()
{
  size(800,800);
  background(255);
  fill(0);
  stroke (255);
  loop();
  PFont fontA = loadFont("courier");
  textFont(fontA, 14);  
  

}

void draw(){  
  
  radius = 100;
  
  fill(255);
  stroke(0);
  strokeWeight(8);
  rect(20, 20, 760, 760);
  fill(255, 255, 255, 0);
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