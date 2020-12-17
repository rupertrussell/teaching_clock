
// Clock face by Rupert Russell
// 31 Dec 2016 - 2 Jan 2017
// v24

// How to calculate points on a circle
// Based on code from http://www.mathopenref.com/coordcirclealgorithm.html

PFont font;
float steps = 12;

void setup() {
  background(255); 
  font = loadFont("ComicSansMS-Bold-248.vlw");
  size(2900, 2900);  // Size of finished clock
  noLoop();
  smooth();
}

float clockRadius = 2900 / 2;

void draw() {
  fill(100);
  ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
  strokeWeight(10); 

  // Draw Right side "Past" half circle and colour it yellow
  fill(255, 255, 0);
  arc(width/2, height/2, width * 0.49, height * 0.49, radians(-90), radians(90), PIE);

  // Draw the Left side "To" half circle and colour it blue
  fill(0, 0, 255);
  arc(width/2, height/2, width * 0.49, height * 0.49, radians(90), radians(270), PIE);



  // Divide the clock into 60 minute segments
  stroke(0);
  strokeWeight(5); 
  for (float i = 0; i < 360; i = i+( 360 / 60)) {
    line(width/2, height/2, clockRadius * 0.975 *  cos(radians(i + 15 )) + width/2, clockRadius * 0.975 *  sin(radians(i + 15)) + height/2 );
  }

  // White center
  fill(255);
  stroke(0);
  strokeWeight(2); 
  ellipse(width/2, height/2, width/2.3, height/2.3);


  // Divide the clock into 12 hour segments
  stroke(0);
  strokeWeight(10); 
  for (float i = 0; i < 360; i = i+( 360 / steps)) {
    line(width/2, height/2, clockRadius * 0.8655 *  cos(radians(i + 15 )) + width/2, clockRadius * 0.8655 *  sin(radians(i + 15)) + height/2 );
  }

  strokeWeight(10); 
  // Draw Right side "Past" half circle and colour it yellow
  fill(255, 255, 0);
  arc(width/2, height/2, width/4, height/4, radians(-90), radians(90), PIE);

  // Draw the Left side "To" half circle and colour it blue
  fill(0, 0, 255);
  arc(width/2, height/2, width/4, height/4, radians(90), radians(270), PIE);


  // Black center spot
  fill(0);
  stroke(0);
  strokeWeight(2); 
  ellipse(width/2, height/2, 15, 15);

  // Dashes for each hour
  strokeWeight(15); 
  double step =  radians(360) / 12;// see note 1
  float h = width / 2; 
  float k = height /2;
  float r = clockRadius / 2;

  for (float theta=0; theta < 2 * PI; theta += step) {
    float x1 = h + r * 1.1 * cos(theta);
    float y1 = k - r * 1.1 * sin(theta); //note 2.

    float x2 = h + r * 0.9 * cos(theta);
    float y2 = k - r * 0.9 * sin(theta); //note 2.
    line(x1, y1, x2, y2);  // draw the dashes for each hour
  }

  // Number for each hour
  int count = 13;

  for (float theta = radians(90); theta < radians(420); theta += step) {
    count = count  - 1;

    float x1 = h + r * 1.35 * cos(theta);
    float y1 = k - r * 1.35 * sin(theta); //note 2.  

    textFont(font, 248);
    textAlign(CENTER, CENTER);
    text(count, x1, y1);
  }


  // Number for each minute - to the next hour
  fill(255, 255, 255);
  int minuteCount = -1;

  for (float theta=radians(90); theta < radians(270); theta += radians(360 / 60)) {
    minuteCount = minuteCount  + 1;

    float x1 = h + r * 1.85 * cos(theta);
    float y1 = k - r * 1.85 * sin(theta); //note 2.  

    textFont(font, 100);
    textAlign(CENTER, CENTER);
    text(minuteCount, x1, y1);

    println ("minute to the Hour = " + minuteCount);
    println("angle =  " + theta);
  }

  // Number for each minute - past the hour

  fill(0);
  int minuteCountPast = 31;

  for (float theta=radians(270); theta < radians(360+90); theta += radians(360 / 60)) {
    minuteCountPast = minuteCountPast  - 1;

    float x1 = h + r * 1.85 * cos(theta);
    float y1 = k - r * 1.85 * sin(theta); //note 2.  

    textFont(font, 100);
    textAlign(CENTER, CENTER);
    text(minuteCountPast, x1, y1);
  }

  // Draw the O'Clock marker
  stroke(0);
  strokeWeight(5); 
  fill(255);
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;
  float x4;
  float y4;

  x1 = clockRadius * 0.8 *  cos(radians(270 - 3)) + width/2;
  y1 = clockRadius * 0.8 *  sin(radians(270 - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(270 - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(270 - 3)) + height/2;

  x4 = clockRadius * 0.8 *  cos(radians(270 + 3)) + width/2;
  y4 = clockRadius * 0.8 *  sin(radians(270+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(270 + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(270 + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);


  x1 = clockRadius * 0.8 * cos(radians(270)) + width/2;
  y1 = clockRadius * 0.8 * sin(radians(270)) + height/2;

  ellipseMode(CENTER);
  //  ellipse(x1, y1, 120, 120);

  stroke(0);
  strokeWeight(5);
  arc(x1, y1 - 2, 121, 121, 0, PI);

  // The word O'Clock is added just before saving the image
  // because I use Translate & Rotate to turn the ttext 90 degrees
  // I might be able to put ig ** Here and use Push matrix and pop matrix???


  //  - Finish drawing the O'Clock marker


  // Draw the 1/2 past marker
  stroke(0);
  strokeWeight(5); 
  fill(255);
  float heightOfMarker = 0.80;

  x1 = clockRadius * heightOfMarker *  cos(radians(90 - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(90 - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(90 - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(90 - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(90 + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(90+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(90 + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(90 + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);


  fill(254, 193, 4);
  heightOfMarker = 0.87;

  x1 = clockRadius * heightOfMarker *  cos(radians(90 - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(90 - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(90 - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(90 - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(90 + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(90+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(90 + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(90 + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);


  x1 = clockRadius * heightOfMarker * cos(radians(90)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(90)) + height/2;

  ellipseMode(CENTER);
  stroke(0);
  strokeWeight(5);

  fill(254, 193, 4);
  arc(x1, y1 + 2, 133, 133, PI, 2 * PI);

  // white arc 
  heightOfMarker = 0.80;
  x1 = clockRadius * heightOfMarker * cos(radians(90)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(90)) + height/2;

  ellipseMode(CENTER);
  stroke(0);
  strokeWeight(5);

  fill(255);
  arc(x1, y1 + 2, 121, 121, PI, 2 * PI);



  // print number 30
  x1 = h + r * 1.8 * cos(3 * PI / 2);
  y1 = k - r * 1.8 * sin(3 * PI / 2); //note 2.  
  fill(0);
  font = loadFont("ComicSansMS-Bold-115.vlw");
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("30", x1 -2, y1 );


  // Print 1/4 to
  // print number 30
  x1 = h + r * 1.6 * cos(3 * PI / 2);
  y1 = k - r * 1.6 * sin(3 * PI / 2); //note 2.  
  fill(0);
  font = loadFont("ComicSansMS-Bold-48.vlw");
  textFont(font, 48);
  textAlign(CENTER, CENTER);
  text("1/2", x1, y1 -22 );
  text("past", x1, y1 + 14);




  //  - Finish drawing the 1/2 past marker


  // Drawing the 25 minutes to the hour marker
  stroke(0);
  strokeWeight(5); 
  fill(0, 0, 110);
  heightOfMarker = 0.87;
  int position = 30 + 90;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  stroke(0);
  strokeWeight(5);
  fill(0, 0, 110);
  ;
  arc(x1 - 1.1, y1 + 2, 132, 132, PI + radians(30), 2 * PI + radians(30));

  // print number 25 to the hour
  x1 = h + r * 1.8 * cos(4.188788);
  y1 = k - r * 1.8 * sin(4.188788); //note 2.  
  fill(255);
  font = loadFont("ComicSansMS-Bold-115.vlw");
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("25", x1, y1 );


  //  - Finish drawing the 25 minutes to the hour marker


  // Drawing the 20 minutes to the hour marker
  stroke(0);
  strokeWeight(5); 
  fill(0, 0, 110);
  heightOfMarker = 0.87;
  position = 30 + 30 + 90;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  stroke(0);
  strokeWeight(5);
  fill(0, 0, 110);
  arc(x1 - 1.5, y1 + 1, 132.5, 132.5, PI + radians(60), 2 * PI + radians(60));

  // print number 20 to the hour
  x1 = h + r * 1.8 * cos(3.6651897);
  y1 = k - r * 1.8 * sin(3.6651897); //note 2.  
  fill(255);
  font = loadFont("ComicSansMS-Bold-115.vlw");
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("20", x1 - 2, y1 -2 );

  //  - Finish drawing the 20 minutes to the hour marker


  // Drawing the 1/4 to the hour marker
  stroke(0);
  strokeWeight(5); 
  fill(0, 0, 110);
  heightOfMarker = 0.87;
  position = 30 + 30 + 30 + 90;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  stroke(0);
  strokeWeight(5);
  fill(0, 0, 110);
  arc(x1 - 1.5, y1, 132.5, 132.5, PI + radians(90), 2 * PI + radians(90));

  noFill();
  heightOfMarker = 0.78;
  position = 30 + 30 + 30 + 90;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  fill(255);
  arc(x1 - 1.5, y1, 119, 119, PI + radians(90), 2 * PI + radians(90));

  // print number 15 to the hour
  x1 = h + r * 1.8 * cos(PI);
  y1 = k - r * 1.8 * sin(PI); //note 2.  
  fill(255);
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("15", x1 - 2, y1 -2 );



  // print 1/4 To
  x1 = h + r * 1.6 * cos(PI);
  y1 = k - r * 1.6 * sin(PI); //note 2.  
  fill(0);
  font = loadFont("ComicSansMS-Bold-48.vlw");
  textFont(font, 48);
  textAlign(CENTER, CENTER);
  text("1/4", x1 + 14, y1 - 25);
  text("To", x1 + 15, y1 + 20);


  //  - Finish drawing the 1/4 to the hour marker


  // Drawing the 10 to the hour marker
  stroke(0);
  strokeWeight(5); 
  fill(0, 0, 110);
  heightOfMarker = 0.87;
  position = 30 + 30 + 30 + 30 + 90;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  stroke(0);
  strokeWeight(5);
  fill(0, 0, 110);
  arc(x1 - 1.5, y1 - 1, 132.5, 132.5, PI + radians(90 + 30), 2 * PI + radians(90 + 30));

  // print number 10 to the hour
  x1 = h + r * 1.8 * cos(5 * PI /6 );
  y1 = k - r * 1.8 * sin(5 * PI /6 ); //note 2.  
  fill(255);
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("10", x1 - 2, y1 -2 );
  // Finish Drawing the 10 to the hour marker


  // Drawing the 5 to the hour marker
  stroke(0);
  strokeWeight(5); 
  fill(0, 0, 110);
  heightOfMarker = 0.87;
  position = 30 + 30 + 30 + 30 + 30 + 90;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  stroke(0);
  strokeWeight(5);
  fill(0, 0, 110);
  arc(x1 -0.75, y1 - 1.5, 132.9, 132.9, PI + radians(90 + 30 + 30), 2 * PI + radians(90 + 30 + 30));

  // print number 5 to the hour
  x1 = h + r * 1.8 * cos(2 * PI /3);
  y1 = k - r * 1.8 * sin(2 * PI /3); //note 2.  
  fill(255);
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("5", x1 - 2, y1 -2 );
  // Finish Drawing the 10 to the hour marker


  // Finish Drawing the 5 to the hour marker


  // Drawing the 5 past the hour marker
  stroke(0);
  strokeWeight(5); 
  fill(254, 193, 4);
  heightOfMarker = 0.87;
  position = 300;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  stroke(0);
  strokeWeight(5);
  fill(254, 193, 4);
  arc(x1 +1, y1 - 1.5, 132.9, 132.9, PI + radians(210), 2 * PI + radians(210));



  // --------------------------------------

  // Number for each minute - past the hour

  fill(0);


  minuteCountPast = 31;

  for (float theta=radians(270); theta < radians(360+90); theta += radians(360 / 60)) {
    minuteCountPast = minuteCountPast  - 1;

    x1 = h + r * 1.85 * cos(theta);
    y1 = k - r * 1.85 * sin(theta); //note 2.  

    textFont(font, 100);
    textAlign(CENTER, CENTER);
    //   text(minuteCountPast, x1, y1);
  }

  x1 = h + r * 1.8 * cos(7.33038);
  y1 = k - r * 1.8 * sin(7.33038); //note 2.  
  font = loadFont("ComicSansMS-Bold-115.vlw");
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("5", x1, y1);

  // ------------------------------------

  // Finish Drawing the 5 past the hour marker


  // Drawing the 10 past the hour marker
  stroke(0);
  strokeWeight(5); 
  fill(254, 193, 4);
  heightOfMarker = 0.87;
  position = 330;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  stroke(0);
  strokeWeight(5);

  fill(254, 193, 4);
  arc(x1 +1, y1 - 1.5, 132.9, 132.9, PI + radians(240), 2 * PI + radians(240));

  x1 = h + r * 1.8 * cos(6.806782);
  y1 = k - r * 1.8 * sin(6.806782); //note 2.  
  fill(0);
  font = loadFont("ComicSansMS-Bold-115.vlw");
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("10", x1, y1);

  //  



  // Finish Drawing the 10 past the hour marker



  // Drawing the 1/4 past the hour marker -----------------
  stroke(0);
  strokeWeight(5); 
  fill(254, 193, 4);
  heightOfMarker = 0.87;
  position = 360;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  stroke(0);
  strokeWeight(5);
  fill(254, 193, 4);
  arc(x1 + 1.5, y1, 132.5, 132.5, PI + radians(270), 2 * PI + radians(270));

  noFill();
  heightOfMarker = 0.78;

  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  fill(255);
  arc(x1 + 1.5, y1, 119, 119, PI + radians(270), 2 * PI + radians(270));

  // print number 15
  x1 = h + r * 1.8 * cos(6.2831836);
  y1 = k - r * 1.8 * sin(6.2831836); //note 2.  
  fill(0);
  font = loadFont("ComicSansMS-Bold-115.vlw");
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("15", x1, y1);

  // print 1/4 Past
  x1 = h + r * 1.6 * cos(6.2831836);
  y1 = k - r * 1.6 * sin(6.2831836); //note 2.  
  fill(0);
  font = loadFont("ComicSansMS-Bold-48.vlw");
  textFont(font, 48);
  textAlign(CENTER, CENTER);
  text("1/4", x1 - 14, y1 - 25);
  text("Past", x1 - 15, y1 + 20);


  //  - Finish drawing the 1/4 to the hour marker ---------------

  // Drawing the 20 past the hour marker
  stroke(0);
  strokeWeight(5); 
  fill(254, 193, 4);
  heightOfMarker = 0.87;
  position = 330 + 60;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  stroke(0);
  strokeWeight(5);
  fill(254, 193, 4);
  arc(x1 + 1.5, y1 + 0.8, 132.69, 132.69, PI + radians(240+ 60), 2 * PI + radians(240 + 60));


  // print number 20
  x1 = h + r * 1.8 * cos(5.7595854);
  y1 = k - r * 1.8 * sin(5.7595854); //note 2.  
  fill(0);
  font = loadFont("ComicSansMS-Bold-115.vlw");
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("20", x1 + 4, y1 - 2);



  // Finish Drawing the 20 past the hour marker


  // Drawing the 25 past the hour marker
  stroke(0);
  strokeWeight(5); 
  fill(254, 193, 4);
  heightOfMarker = 0.87;
  position = 330 + 60 + 30;
  x1 = clockRadius * heightOfMarker *  cos(radians(position - 3)) + width/2;
  y1 = clockRadius * heightOfMarker *  sin(radians(position - 3)) + height/2;

  x2 = clockRadius * 0.98 * cos(radians(position - 3)) + width/2;
  y2 = clockRadius * 0.98 * sin(radians(position - 3)) + height/2;

  x4 = clockRadius * heightOfMarker *  cos(radians(position + 3)) + width/2;
  y4 = clockRadius * heightOfMarker *  sin(radians(position+ 3)) + height/2;

  x3 = clockRadius * 0.98 * cos(radians(position + 3)) + width/2;
  y3 = clockRadius * 0.98 * sin(radians(position + 3)) + height/2;

  quad(x1, y1, x2, y2, x3, y3, x4, y4);

  x1 = clockRadius * heightOfMarker * cos(radians(position)) + width/2;
  y1 = clockRadius * heightOfMarker * sin(radians(position)) + height/2;

  stroke(0);
  strokeWeight(5);
  fill(254, 193, 4);
  arc(x1 + 1.0, y1 + 1.5, 132.69, 132.69, PI + radians(240 + 90), 2 * PI + radians(240 + 90));


  // print number 25
  x1 = h + r * 1.8 * cos(5.235987);
  y1 = k - r * 1.8 * sin(5.235987); //note 2.  
  fill(0);
  font = loadFont("ComicSansMS-Bold-115.vlw");
  textFont(font, 115);
  textAlign(CENTER, CENTER);
  text("25", x1 + 4, y1 - 2);

  // Finish Drawing the 25 past the hour marker

  //  Print MINUTES TO
  fill(255);
  font = loadFont("ComicSansMS-Bold-115.vlw");
  textFont(font, 90);
  textAlign(CENTER, CENTER);
  text("MINUTES", width / 3 + 150, height / 3 + 420);
  font = loadFont("ComicSansMS-Bold-150.vlw");
  textFont(font, 180);
  text("TO", width / 3 + 150, height / 3 + 580);

  //  Print MINUTES PAST
  fill(0);
  font = loadFont("ComicSansMS-Bold-115.vlw");
  textFont(font, 90);
  textAlign(CENTER, CENTER);
  text("MINUTES", width /2 + 350, height / 3 + 420);
  font = loadFont("ComicSansMS-Bold-150.vlw");
  textFont(font, 180);
  text("PAST", width /2 + 350, height / 3 + 580);



  // print number O'Clock
  x1 = h + r * 1.8 * cos( PI / 2);
  y1 = k - r * 1.8 * sin( PI / 2); //note 2.  
  fill(0);
  font = loadFont("ComicSansMS-Bold-78.vlw");
  textFont(font, 78);
  textAlign(CENTER, CENTER);

  translate(width /2, height / 2);
  rotate(radians(90));
  text("O'Clock", - 1265, -5 );



  save("teaching_clock.png");
  exit();
}

/*
Like most graphics systems, the canvas element differs from the usual mathematical coordinate plane:
 
 The origin is in the top left corner. 
 The code above compensates by assuming that h, and k are actually relative to the top left.
 The y axis is inverted. Positive y is down the screen, not up. To correct for this, the k variable (the y coordinate of the center) must be positive to place the center some way down the screen. 
 
 Also the y calculation has to subtract the sin(x) term instead of add. 
 Marked in the code as Note 1.
 
 Note 2. The step size is set to an exact division of 2π to avoid gaps or over-runs in the circle. This code divides the circle into exactly 20 segments. 
 Note too that as in most computer languages, the trig functions operate in radians, not degrees. 
 360° = 2π radians.
 */
