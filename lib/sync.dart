import 'package:http/http.dart' as http;

void main() {

  print("ok");
  var ok = "";
  
  Future result = http.get(Uri.parse("http://google.com"));
  result.then((value) {
    print('ok');
  }).onError((error, stackTrace) {
    print('error');
  });
  print("reza");
  
  
  
}