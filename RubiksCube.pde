import peasy.*;

PeasyCam cam;
int dim = 3;
Box[] cube = new Box[dim*dim*dim];
PFont f;

void setup() {
  size(1000, 1000, P3D);
  fill(0);
  f = createFont("Arial",16, true);
  cam = new PeasyCam(this, 600);
  int index = 0;
  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      for (int z = -1; z <= 1; z++){
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x, y, z);
        cube[index] = new Box(matrix, x, y, z);
        index++;
      }
    }
  }
  cube[0].c = color(255, 0, 0);
  cube[2].c = color(0, 0, 255);
}

int index = 0;

void turnZ(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Box qb = cube[i];
    if (qb.z == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.x, qb.y);
      qb.turnFacesZ(dir);
      qb.update(round(matrix.m02), round(matrix.m12), round(qb.z));
    }
  }
}

void turnY(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Box qb = cube[i];
    if (qb.y == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.x, qb.z);
      qb.turnFacesY(dir);
      qb.update(round(matrix.m02), round(qb.y), round(matrix.m12));
    }
  }
}

void turnX(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Box qb = cube[i];
    if (qb.x == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.y, qb.z);
      qb.turnFacesX(dir);
      qb.update(round(qb.x), round(matrix.m02), round(matrix.m12));
    }
  }
}

void keyPressed() {
  switch (key) 
  {
    case 'f':
      turnZ(1, 1);
      break;
    case 'F':
      turnZ(1, -1);
      break;
    case 'b':
      turnZ(-1, 1);
      break;
    case 'B':
      turnZ(-1, -1);
      break;
    case 'u':
      turnY(-1, 1);
      break;
    case 'U':
      turnY(-1, -1);
      break;
    case 'd':
      turnY(1, 1);
      break;
    case 'D':
      turnY(1, -1);
      break;
    case 'l':
      turnX(-1, 1);
      break;
    case 'L':
      turnX(-1, -1);
      break;
    case 'r':
      turnX(1, 1);
      break;
    case 'R':
      turnX(1, -1);
      break;
  }
}

void text(){
}

void draw(){
  background(255);
  textFont(f);
  fill(0);
  textAlign(RIGHT);
  text("Rotate Clockwise:" + '\n'
  + "Front: f" + '\n'
  + "Back: b" + '\n'
  + "Top: u" + '\n'
  + "Bottom: d" + '\n'
  + "Left: l" + '\n'
  + "Right: r",-100, -70);
  textAlign(LEFT);
  text("Rotate Counter-CW:" + '\n'
  + "Front: F" + '\n'
  + "Back: B" + '\n'
  + "Top: U" + '\n'
  + "Bottom: D" + '\n'
  + "Left: L" + '\n'
  + "Right: R",100, -70);
  scale(50);
  for (int i = 0; i < cube.length; i++) {
    cube[i].show();
  }
}
