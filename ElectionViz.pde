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
  size(640, 480);
  loadData();
  font = createFont("Arial", 14, true);
  textFont(font);
  background(BLACK);
   xPos=width*.22;
   yPos = height*.8 - 20;

}

void showOptions() {
  fill(GRAY);
  rect(10, 10, 100, buttonHeight);
  rect(120, 10, 100, buttonHeight);

  fill(BLACK);
  text("Obama", 35, 10+18);
  text("Romney", 120+25, 10+18); 
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
  text("Margin of Obama Victory: " + filterPct + "%", 50, height*.8-25);
  rect(50, height*.8, 450, 4);
  // make the moving part
  fill(WHITE);
  rect(xPos, yPos, 10, 40);
}

void displayState(StateData state, int count) {
  int pctRomney = state.pctForRomney;
  int a = 50 + (count%5)*110;
  int b = 70+ (count / 5) * 50;
  String name = state.name;
  
  noStroke();
  fill(0, 0, 255);
  rect(a, b, 100, 20);
  fill(255,0,0);
  noStroke();
  rect(a, b, pctRomney, 20);
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
         println(state.name);
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
