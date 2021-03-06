Sun theSun;
void setup() {
  size(1280, 1024);
  noStroke();
  colorMode(HSB, 360, 100, 100);
  theSun = new Sun(100, width / 2, height / 2);
}

void draw() {
  background(0, 0, 100);
  theSun.start();
}

class Sun {
  final float radius;
  final float x;
  final float y;
  Earth theEarth;
  Sun(float radius, float x, float y) {
    this.radius=radius;
    this.x=x;
    this.y=y;
    theEarth =new Earth(20, x, y);
  }

  void start() {
    drawFigure();
    move();
  }
  void drawFigure() {
    theEarth.drawFigure();       // Earthオブジェクトに描画を指示
    fill(30, 100, 100);
    ellipse(x, y, radius, radius);         // 自分自身を描画
  }
  void move() {
    theEarth.move();
  }
}

class Earth {
  Moon theMoon;
  float radius;
  float x;
  float y;
  float orbitRadius=200;//回転半径
  float theta;

  Earth(float radius, float x, float y) {
    this.radius=radius;
    this.x=x;
    this.y=y;
    theMoon =new Moon(10, this.x, this.y,this);
  }

  void start() {
    drawFigure();
    move();
  }

  void move() {
    theta+=2;
    theta=theta%360;
    float rad = radians(theta);
    x =  theSun.x+orbitRadius * cos(rad);
    y = theSun.y-orbitRadius * sin(rad);
    theMoon.move();
  }

  void drawFigure() {
    fill(240, 100, 100);
    ellipse(x, y, radius, radius);         // 自分自身を描画
    System.out.println("EARTH"+x+"."+y);
    theMoon.drawFigure();
  }
}

class Moon{
  float radius;
  float x;
  float y;
  float orbitRadius=50;//回転半径
  float theta;
  Earth theEarth;

  Moon(float radius, float x, float y,Earth theEarth) {
    this.radius=radius;
    this.x=x;
    this.y=y;
    this.theEarth=theEarth;
  }

  void start() {
    drawFigure();
    move();
  }

  void move() {
    theta+=4;
    theta=theta%360;
    float rad = radians(theta);
    x = theEarth.x+orbitRadius * cos(rad);
    y = theEarth.y-orbitRadius * sin(rad);
  }

  void drawFigure() {
    fill(60, 100, 100);
    ellipse(x, y, radius, radius);         // 自分自身を描画
    System.out.println("MOON"+x+"."+y);
  }
}