SpaceShip bob = new SpaceShip();
ArrayList<Asteroid> ling = new ArrayList<Asteroid>();
ArrayList<Asteroid> jindelete = new ArrayList<Asteroid>();
Star[] li = new Star[10];
boolean up=false;
boolean left=false;
boolean right=false;//your variable declarations here
public void setup() 
{
  size(600,600);
  background(0);
  li = new Star[400];
  for(int i=0; i<li.length;i++)
  {
    li[i] = new Star();
  }
  for(int i=0; i<20;i++)
  { 
    ling.add(new Asteroid());
  }
}
public void draw()
{
  for(Asteroid a : jindelete)
  {
    ling.remove(a);
  }
  jindelete = new ArrayList<Asteroid>();

  background(0);
  if(up){bob.accelerate(.1);}
  if(left){bob.rotate(-5);}
  if(right){bob.rotate(5);}
  for(int i=0;i<li.length;i++)
    li[i].show();
  for(Asteroid a:ling)
  {
    a.move();
    a.show();
  }
  bob.move();
  bob.show();
}
public void keyPressed()
{  
      if(key=='w'){up=true;}
      if(key=='a'){left=true;}
      if(key=='d'){right=true;}
}
public void keyReleased()
{  
      if(key=='w'){up=false;}
      if(key=='a'){left=false;}
      if(key=='d'){right=false;}
}
class Star{
  private int myX, myY;
  public Star()
  {
    myX = (int)(Math.random()*600);
    myY = (int)(Math.random()*600);
  }
  void show()
  {
    fill(255,255,204);
    ellipse(myX,myY,1,1);
  }
}
class Asteroid extends BetterFloater
{
  private int spin;
  public Asteroid()
  {
      myColor=(205);
      myCenterX = 300;
      myCenterY = 300;
      corners = 4;
      xCorners = new int[corners];
      yCorners = new int[corners];
      xCorners[0] = -8;
      yCorners[0] = -8;
      xCorners[1] = 16;
      yCorners[1] = 0;
      xCorners[2] = -8;
      yCorners[2] = 8;
    setX ((int)0);
    setY ((int)(Math.random()*600));
    setDirectionX ((Math.random()*5)-2);
    setDirectionY ((Math.random()*5)-2);
    setPointDirection((int)(Math.random()*360));
    spin = (int)((Math.random()*5)-3);
  }
  public void move()
  {
    super.move();
    rotate(spin);
    if(dist((float)myCenterX, (float)myCenterY, (float)bob.getX(), (float)bob.getY()) < 35)
    {
      jindelete.add(this);
    }
  }
  public void show()
  {
    strokeWeight(1);
    stroke(myColor);
    fill(myColor);   
    super.show();
  }
}
class SpaceShip extends BetterFloater  
{   
  public SpaceShip(){
      myColor=(255);
      myCenterX = 300;
      myCenterY = 300;
      corners = 4;
      xCorners = new int[corners];
      yCorners = new int[corners];
      xCorners[0] = -8;
      yCorners[0] = -8;
      xCorners[1] = 16;
      yCorners[1] = 0;
      xCorners[2] = -8;
      yCorners[2] = 8;
    for (int i=0;i<corners;i++)
    {
      xCorners[i] *= 2.2;
      yCorners[i] *= 2.2;
    }
  }
  public void show()
  {
    strokeWeight(1);
    stroke(myColor);
    fill(myColor);   
    super.show();
  }
  }
class BetterFloater extends Floater
{
  //I've given up on commenting so good luck
  public void setX(int x) {this.myCenterX = x;} 
  public int getX() {return (int)this.myCenterX;}
  public void setY(int y) {this.myCenterY = y;}
  public int getY() {return (int)this.myCenterY;}
  public void setDirectionX(double x) {this.myDirectionX = x;}
  public double getDirectionX() {return this.myDirectionX;}
  public void setDirectionY(double y) {this.myDirectionY = y;}
  public double getDirectionY() {return this.myDirectionY;}
  public void setPointDirection(int degrees) {this.myPointDirection = degrees;}
  public double getPointDirection() {return this.myPointDirection;}

  public void show()
  {  
    double dRadians = myPointDirection*(Math.PI/180);

    showAtRelPos(-width, -height, dRadians);
    showAtRelPos(-width, 0, dRadians);
    showAtRelPos(-width, height, dRadians);

    showAtRelPos(0, -height, dRadians);
    showAtRelPos(0, 0, dRadians);
    showAtRelPos(0, height, dRadians);

    showAtRelPos(width, -height, dRadians);
    showAtRelPos(width, 0, dRadians);
    showAtRelPos(width, height, dRadians);
  }

  protected double getRotatedX(double x, double y, double dRadians)
  {
    return (x * Math.cos(dRadians)) - (y * Math.sin(dRadians));
  }

  protected double getRotatedY(double x, double y, double dRadians)
  {
    return (x * Math.sin(dRadians)) + (y * Math.cos(dRadians));
  }

  private void showAtRelPos(int relX, int relY, double dRadians)
  {
    //convert degrees to radians for sin and cos         
                     
    float xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (float)(getRotatedX(xCorners[nI], yCorners[nI], dRadians)+(myCenterX + relX));     
      yRotatedTranslated = (float)(getRotatedY(xCorners[nI], yCorners[nI], dRadians)+(myCenterY + relY));      
      vertex(xRotatedTranslated,yRotatedTranslated);
    }   
    endShape(CLOSE);
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 







    
