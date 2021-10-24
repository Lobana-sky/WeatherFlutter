import 'package:http/http.dart'
    as http; // to know that it is for fetch data and it is from http package
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      // return value is dynamic and we do not know what is the data type until it is come.
      return jsonDecode(data);
      // these should be int or string or.... to make it more explicit
      
    } else {
      print(response.statusCode);
    }
  }
}
