// Fred L
// 25/02/2017
// fixed: 18/03/2017

class Ball {
  PVector pos;
  PVector vel;
  float diam;
  float speed;
  float accel;

  Ball () {
    this.speed = 5;
    this.diam = 25;
    this.accel = 1.05;
    reset();
  }

  void reset () {
    float angle;
    float dir;
    this.pos = new PVector(width/2, height/2);
    this.vel = new PVector(this.speed, 0);
    while (true) {
      angle = random(-PI/4, PI/4);
      if (abs(angle) > (PI/10)) {
        break;
      }
    }
    dir = (random(2) < 1) ? angle : (angle - PI);
    this.vel.rotate(dir);
  }

  boolean isGoalL () {
    return (this.pos.x < 0);
  }

  boolean isGoalR () {
    return (this.pos.x > width);
  }

  void bounce () {
    if (this.pos.y < 0) {
      this.pos.y = 0;
      this.vel.y = this.vel.y * (-1);
    }
    if (this.pos.y > height) {
      this.pos.y = height;
      this.vel.y = this.vel.y * (-1);
    }
  }

  boolean collision (Paddle other) {
    // We know how to find if a circle hits a single point by showing that if the distance
    // between the center of the circle and the point is less than the circle's radius, then
    // there is collision.
    // We therefore only need to find out which is the best (closest) point on the rectangle
    // perimeter and apply that rule on that point.
    // So firstly, find the point on the rectangle (paddle) that is the closest from the 
    // circle (ball)
    // Then check the distance from that point to the ball's center.
    float rectXmin = other.pos.x - (other.padW / 2);
    float rectXmax = rectXmin + other.padW;
    float rectYmin = other.pos.y - (other.padH / 2);
    float rectYmax = rectYmin + other.padH;
    float closestX = max(rectXmin, min(this.pos.x, rectXmax));
    float closestY = max(rectYmin, min(this.pos.y, rectYmax));
    float d = dist(closestX, closestY, this.pos.x, this.pos.y);
    return ((d + 2) <= (this.diam/2));
  }

  void update (Paddle pL, Paddle pR) {
    boolean collided = false;
    this.pos.add(this.vel);
    if (isGoalL()) {
      pR.score++;
      reset();
    }
    if (isGoalR()) {
      pL.score++;
      reset();
    }
    bounce();
    if (collision(pL)) {
      collided = true;
      pL.beenHit();
      this.pos.x = (pL.pos.x + pL.padW + 1);
    }
    if (collision(pR)) {
      collided = true;
      pR.beenHit();
      this.pos.x = (pR.pos.x - pR.padW - 1);
    }
    if (collided) {
      this.vel.x = this.vel.x * (-1);
      this.vel.mult(this.accel);
      float jitter = random(-PI/20, PI/20);
      this.vel.rotate(jitter);
    }
  }

  void show () {
    fill(127);
    stroke(255);
    strokeWeight(3);
    ellipseMode(CENTER);
    ellipse(this.pos.x, this.pos.y, this.diam, this.diam);
  }
}