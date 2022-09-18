

void main() {
  // Hi
  var input = ["ali", "reza", "mehdi", "mohammad"];
  var splitLength = input.length ~/ 2;
  var listGroup1 = [];
  var listGroup2 = [];
  for (var i = 0; i < input.length; i++) {
    if(i < splitLength || input[i] == "reza") {
      listGroup1.add(input[i]);
    } else {
      listGroup2.add(input[i]);
    }
  }
  print("Group 1");
  print(listGroup1);
  print("Group 2");
  print(listGroup2);


}

String getName() {
  return "Mohammad";
}


