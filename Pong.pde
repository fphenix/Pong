// Fred L
// 25/02/2017

Paddle padL;
Paddle padR;
Ball ball;
Field field;
boolean onOff;
boolean winL;
boolean winR;
boolean newGame;

void setup () {
  size(800, 600, P2D);
  padL = new Paddle(true);
  padR = new Paddle(false);
  ball = new Ball();
  field = new Field();
  onOff = false;
  winL = false;
  winR = false;
  newGame = false;
}

void draw () {
  background(0);
  field.show();
  field.dstart(!onOff);
  ball.show();
  padL.show();
  padR.show();
  field.update(padL.score, padR.score);
  if ((winL || winR) && onOff && !newGame) {
    onOff = false;
    newGame = true;
  } else if (newGame && onOff) {
    padL.reset();
    padR.reset();
    newGame = false;
  }
  winL = padL.iWin();
  winR = padR.iWin();
  if (onOff) {
    ball.update(padL, padR);
    padL.update();
    padR.update();
  }
}

void keyPressed () {
  if (key == ' ') {
    onOff = !onOff;
  }

  if (key == padL.keyUp) {
    padL.goUp = true;
  }
  if (key == padL.keyDown) {
    padL.goDown = true;
  }
  if (key == padR.keyUp) {
    padR.goUp = true;
  }
  if (key == padR.keyDown) {
    padR.goDown = true;
  }
}

void keyReleased () {
  if (key == padL.keyUp) {
    padL.goUp = false;
  }
  if (key == padL.keyDown) {
    padL.goDown = false;
  }
  if (key == padR.keyUp) {
    padR.goUp = false;
  }
  if (key == padR.keyDown) {
    padR.goDown = false;
  }
}