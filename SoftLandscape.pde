void setup()
{ 
  fullScreen(P3D);
  //size(1400, 700, P3D); 
  colorMode(HSB);
}

void keyPressed() {
  drawLandscape();
  saveImage();
}

void draw()
{
}

void drawLandscape() {
  int baseHue = (int) random(0, 255);
  int skyHue = (int) random(0, 255);

  background(skyHue, 13, 243);
  noStroke();

  translate(0, 0, -400);

  int saturation = 15;
  int brightness = 240;
  int layerOffset = 0;

  for (int layer=0; layer<6; layer++)
  {   
    color layerColor = color(baseHue, saturation, brightness); 
    color treeColor = color(baseHue, saturation + 10, brightness + 10);
    color lodgeColor = color(baseHue, saturation + 10, brightness - 10);

    fill(layerColor);
    layerOffset += random(30, height/10);

    beginShape();

    vertex(-500, height + 500);
    vertex(-500, 2 * height / 3 + layerOffset);

    int y=height/3 + layerOffset;

    ArrayList<PVector> treeLocations = new ArrayList<PVector>();
    ArrayList<PVector> woodLodgeLocations = new ArrayList<PVector>();

    int x=-500;
    while (x<width+500)
    {
      if (random(0, 100) <10)
        treeLocations.add(new PVector(x, y + (6-layer))); 

      vertex(x, y);  

      x += random(10, 50);
      y += random(-20, 20);
    }

    vertex(x, y);
    vertex(x, height + 500);
    
    endShape();

    drawTrees(treeLocations, treeColor);
    drawLodges(woodLodgeLocations, lodgeColor);

    saturation += random(8, 15);
    brightness -= random(8, 15);

    translate(0, 0, 50);
  }
}

void drawLodges(ArrayList<PVector> lodgeLocations, color c)
{
  for (int i=0; i<lodgeLocations.size(); i++)
  {
    drawLodge(lodgeLocations.get(i), c);
  }
}

void drawLodge(PVector location, color c)
{
  float x = location.x;
  float y = location.y + 4;

  stroke(c);
  strokeWeight(2);

  fill(c); 
  beginShape();

  vertex(x, y);
  vertex(x, y-8);
  vertex(x+8, y-12);
  vertex(x+16, y-8);
  vertex(x+16, y);
  vertex(x, y);

  endShape();
  noStroke();
}

void drawTrees(ArrayList<PVector> treeLocations, color c)
{
  for (int i=0; i<treeLocations.size(); i++)
  {
    drawTree(treeLocations.get(i), c);
  }
}

void drawTree(PVector location, color c) {

  float x = location.x;
  float y = location.y+1;

  stroke(c);
  strokeWeight(1);
  line(x, y-18, x, y);

  line(x, y-18, x-3, y-15);
  line(x, y-18, x+3, y-15);
  line(x, y-15, x-4, y-12);
  line(x, y-15, x+4, y-12);
  line(x, y-12, x-5, y- 9);
  line(x, y-12, x+5, y- 9);
  line(x, y- 9, x-6, y- 6);
  line(x, y- 9, x+6, y- 6);
  line(x, y- 6, x+7, y- 3);
  line(x, y- 6, x-7, y- 3);
  line(x, y- 3, x+8, y- 0);
  line(x, y- 3, x-8, y- 0);

  noStroke();
}

void saveImage()
{
  save("landscapes\\" + timestamp() + ".png");
}

String timestamp()
{
  return nf(year(), 4) + "-" + nf(month(), 2) + "-" + nf(day(), 2) + " " +  nf(hour(), 2) + "-" + nf(minute(), 2) + "-" + nf(second(), 2);
}