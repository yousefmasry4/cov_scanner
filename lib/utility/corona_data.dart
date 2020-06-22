import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Corona_data {
  // ignore: non_constant_identifier_names
  List<data_form> corona_data = List();
  String country_name;
  Future<void> load() async {
    corona_data.removeRange(0, corona_data.length);
    List x = await _load();
    for (var i in x.getRange(0, x.length)) {
      corona_data.add(data_form(
          i["Confirmed"], i["Deaths"], i["Recovered"], i["Active"], i["Date"]));
    }
    print(corona_data);

  }

  Future _load() async {
    try {
      var loc = await http.get(
          "http://api.ipstack.com/154.188.128.5?access_key=cae55b946fcd725391d344868534358a&format=1");
      country_name = await jsonDecode(loc.body)["country_name"];
    }catch(Exception){
        country_name="Egypt";
    }
    var res = await http.get("https://api.covid19api.com/total/country/$country_name");
    // print(set_cookie);
    // print(cd.toString());
    return jsonDecode(res.body);
  }
}

class data_form {
  final int Confirmed, Deaths, Recovered, Active;
  final String Date;

  data_form(
      this.Confirmed, this.Deaths, this.Recovered, this.Active, this.Date);
  get_me(String s) {
    switch (s) {
      case "Confirmed":
        return Confirmed;
      case "Deaths":
        return Deaths;
      case "Recovered":
        return Recovered;
      case "Active":
        return Active;
    }
  }
}
