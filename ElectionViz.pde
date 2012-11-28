// By Jonathan
// Using example code from Rahul
final int GRAY = 155;
final int BLACK = 0;
final int WHITE = 255;
final int buttonHeight =25;

StateData[] stateData;
PFont font;

int filterPct;
boolean obamaMode = true;

void loadData() {
    ElectionData electionData;
    electionData = new ElectionData(loadStrings("data/2012_US_election_state.csv"));
    stateData = electionData.getAllStates();
}
float xPos,yPos;
void setup() {
  size(720, 480);
  loadData();
  font = createFont("Arial", 14, true);
  textFont(font);
  background(BLACK);
   xPos=width*.11;
   yPos = height*.8 - 20;

}

void showOptions() {
  fill(GRAY);
  rect(10, 10, 100, buttonHeight);
  rect(120, 10, 100, buttonHeight);

  fill(BLACK);
  if (obamaMode)
    fill(WHITE);
  text("Obama", 35, 10+18);
 
  fill(BLACK);
  if (!obamaMode)
    fill(WHITE); 
  text("Romney", 120+25, 10+18); 
}

void mousePressed() {
  if (mouseX > 10 && mouseX < 110 && mouseY > 10 && mouseY < 30) {
    obamaMode = true;
  } else if (mouseX > 120 && mouseX < 220 && mouseY > 10 && mouseY < 30) {
    obamaMode = false;
  }
}

void mouseDragged() {
  if (mouseX > width*.1 && mouseX < 500)
  xPos = mouseX; 
  else if (mouseX < 50)
  xPos = 50;
  else if (mouseX > 500)
  xPos = 500;
}


void makeSlider() {
  fill(GRAY);
  float pct = 100* (xPos -50) / 450.0 ;
  filterPct = int(pct);
  String candidate = obamaMode ? "Obama" : "Romney";
  text("Margin of " + candidate + " Victory: " + filterPct + "%", 50, height*.8-25);
  rect(50, height*.8, 450, 4);
  // make the moving part
  fill(WHITE);
  rect(xPos, yPos, 10, 40);
}

void displayState(StateData state, int count) {
  int pctRomney = state.pctForRomney;
  int a = 20 + (count%5)*130;
  int b = 100+ (count / 5) * 50;
  String name = state.name;
  
  noStroke();
  fill(0, 0, 255);
  rect(a, b, 100, 20);
  fill(255,0,0);
  noStroke();
  rect(a, b, pctRomney, 20);
  fill(WHITE);
  text(name, a, b-8);

}

void showRelevantStates() {
  int count = 0;
  for (StateData state : stateData) {
    
    //println(state.pctVictoryObama);
    if (obamaMode) {
      if (state.pctVictoryObama >= filterPct)
           displayState(state, count++);
    } else {
      // romney mode
       if (state.pctVictoryRomney >= filterPct)
         displayState(state, count++);
    }
  }
}

void draw() {
  background(0);
  smooth();

  showOptions();  
  makeSlider();
  showRelevantStates();
}
