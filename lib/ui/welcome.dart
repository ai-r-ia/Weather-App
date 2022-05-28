import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather/model/city.dart';
import 'package:weather/model/constants.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/services/weather_api.dart';
import 'package:weather/ui/home.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  @override
  Widget build(BuildContext context) {
    List<City> cities =
        City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> selectedCities = City.getSelectedCities();

    Constants myconstants = Constants();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myconstants.secondaryColor,
        title: Text('${selectedCities.length} selected'),
      ),
      body: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: size.height * 0.08,
              width: size.width,
              decoration: BoxDecoration(
                  border: cities[index].isSelected == true
                      ? Border.all(
                          color: myconstants.secondaryColor.withOpacity(.6),
                          width: 2,
                        )
                      : Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: myconstants.primaryColor.withOpacity(.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ]),
              child: Row(children: [
                GestureDetector(
                  onTap: (() {
                    setState(() {
                      cities[index].isSelected = !cities[index].isSelected;
                    });
                  }),
                  child: Image.asset(
                    cities[index].isSelected == true
                        ? 'assets/checked.png'
                        : 'assets/unchecked.png',
                    width: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(cities[index].city,
                    style: TextStyle(
                      fontSize: 16,
                      color: cities[index].isSelected == true
                          ? myconstants.primaryColor
                          : Colors.black54,
                    ))
              ]),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myconstants.primaryColor,
        child: const Icon(Icons.pin_drop),
        onPressed: () async {
          final newData = await client.getCurrentWeather(cities.first.city);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Home(data: newData)));
        },
      ),
    );
  }
}
