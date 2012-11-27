// By Jonathan
// Using example code from Rahul

final int BLACK = 0;

StateData[] stateData;


void loadData() {
    ElectionData electionData;
    electionData = new ElectionData(loadStrings("data/2012_US_election_state.csv"));
    stateData = electionData.getAllStates();
}

void setup() {
  background(BLACK);
  size(640, 480);
  loadData();
}

void draw() {
  
}
