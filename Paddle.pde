// Fred L
// 25/02/2017

class Paddle {
  PVector pos;
  boolean sideLeft;
  int score;
  char keyUp;
  char keyDown;
  float hratio;
  float padW;
  float padH;
  float deltaW;
  boolean goUp;
  boolean goDown;
  float yspeed;
  float midX;
  float lose;
  float hsize = 150;
  float scoreMax;

  Paddle (boolean tSide) {
    this.scoreMax = 10;
    this.yspeed = 15;
    this.padW = 20;
    this.hratio = 1.0;
    this.padH = hsize * this.hratio;
    this.deltaW = 50;
    this.sideLeft = tSide;
    this.goUp = false;
    this.goDown = false;
    float xpos;
    float ypos = height/2;
    if (this.sideLeft) {
      this.keyUp = 's';
      this.keyDown = 'x';
      xpos = this.deltaW;
      this.midX = width/4;
      this.lose = 3*width/4;
    } else {
      this.keyUp = '9';
      this.keyDown = '6';
      xpos = width - this.deltaW;
      this.midX = 3*width/4;
      this.lose = width/4;
    }
    this.pos = new PVector(xpos, ypos);
  }

  void reset () {
    this.hratio = 1.0;
    this.padH = hsize * this.hratio;
    this.score = 0;
  }

  void update () {
    this.hratio = constrain((1 - (float(this.score) / 10)), 0.3, 1);
    this.padH = hsize * this.hratio;
    float ymin = this.padH/2;
    float ymax = height-ymin;
    float ty = this.pos.y;
    if (this.goUp != this.goDown) {
      if (this.goUp) {
        ty -= this.yspeed;
      }
      if (this.goDown) {
        ty += this.yspeed;
      }
      this.pos.y = constrain(ty, ymin, ymax);
    }
  }
  
  boolean iWin () {
    if (this.score >= this.scoreMax) {
      fill(255, 0, 64);
      textSize(48);
      //textMode(CENTER);
      text("GAGNANT!!", (this.midX-120), height/2);
      fill(127);
      text("LOSER!!", (this.lose-120), height/2);
      return true;
    } else {
      return false;
    }
  }

  void show () {
    fill(0, 192, 64);
    textSize(16);
    text(this.keyUp, this.pos.x, 20);
    text(this.keyDown, this.pos.x, height-20);
    fill(127);
    stroke(255);
    strokeWeight(3);
    rectMode(CENTER);
    rect(this.pos.x, this.pos.y, this.padW, this.padH, 5);
  }
}