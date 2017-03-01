// Fred L
// 25/02/2017

class Field {
  int scoreL;
  int scoreR;
  
  Field () {
    this.scoreL = 0;
    this.scoreR = 0;
  }
  
  void update (int scoreL, int scoreR) {
    this.scoreL = scoreL;
    this.scoreR = scoreR;   
  }
  
  void show () {
    strokeWeight(2);
    line(width/2, 0, width/2, height);
    textSize(32);
    fill(0,127,255,127);
    text(this.scoreL, width/4, 50);
    text(this.scoreR, 3*width/4, 50);
  }
  
}