class Person{
  Name? name;
  Person({this.name});
}
class Name{
  var firstName = "First";
  var familyName = "Family";
}

void main() {
  var p1 = Person();
  print(p1.name?.familyName);
}