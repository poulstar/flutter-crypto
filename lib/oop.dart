class Building {
  var width = 120;
  var length = 100;
  var levels = 4;

  Building(int width, int length, {levels = 4}) {
    this.width = width;
    this.length = length;
    this.levels = levels;
  }

  int getLandUse() {
    return width * length * levels;
  }

  void describe() {
    print("Building, Width: $width, Length: $length, Levels: $levels, LandUse: ${getLandUse()}");
  }
}

class Hospital extends Building{

  var personnel = 5;

  Hospital() : super(200, 300) {}
}



void main() {
  var building1 = Building(400, 800, levels: 6);
  var building2 = Building(200, 300);
  const name = "";

  building1.describe();
  building2.describe();

  var ok = 4;
  ok.toInt();
}
