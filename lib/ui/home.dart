import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/city.dart';
import 'package:weather/model/constants.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/services/weather_api.dart';
import 'package:weather/ui/weather_item.dart';
import 'package:weather/ui/welcome.dart';

class Home extends StatefulWidget {
  Weather data;
  Home({Key? key, required this.data}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myconstants = Constants();
  WeatherApiClient client = WeatherApiClient();
  var selectedCities = City.getSelectedCities();
  List<String> cities = [];
  String imageUrl = '';
  late List<dynamic> consolidatedWeatherList = [
    // {
    //   'location': "",
    //   'temperature': 0,
    //   'windSpeed': 0,
    //   'humidity': 0,
    //   'feelsLike': 0,
    //   'pressure': 0,
    //   'currentDate': 0,
    //   'weatherStateName': "",
    //   'maxTemp': 0
    // }
  ];

  @override
  void initState() {
    for (int i = 0; i < selectedCities.length; i++) {
      cities.add(selectedCities[i].city);
    }
    super.initState();
  }

  // Shader linear gradient
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static DateFormat dateFormat = DateFormat("EEEE, dd MMMM");
  String formatted = dateFormat.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(cities);
    //this takes the consolidated weather for the next six days for the location searched
    setState(() {
      for (int i = 0; i < 7; i++) {
        // consolidatedWeatherList.add(consolidatedWeatherList[i] = widget.data);
        consolidatedWeatherList.add(widget.data);
        consolidatedWeatherList[i] = widget.data;
      }
    });
    String image = 'clear';
    if (widget.data.temperature > 25) {
      image = 'clear';
    } else if (widget.data.temperature < 25 && widget.data.temperature > 18) {
      image = 'lightrain';
    } else if (widget.data.temperature < 18 && widget.data.temperature > 10) {
      image = 'sleet';
    } else if (widget.data.temperature < 10 && widget.data.temperature > 0) {
      image = 'hail';
    } else if (widget.data.temperature < 0) {
      image = 'snow';
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //profile image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset('assets/profile.png', width: 40, height: 40),
              ),
              //location dropdown
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (() => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Welcome()))),
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 20,
                    color: myconstants.primaryColor,
                  ),
                  Image.asset('assets/pin.png', width: 20),
                  const SizedBox(width: 6),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: widget.data.location,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: cities.map((String location) {
                          return DropdownMenuItem(
                              value: location, child: Text(location));
                        }).toList(),
                        onChanged: (String? newValue) async {
                          if (newValue != null) {
                            widget.data =
                                await client.getCurrentWeather(newValue);
                          }
                          setState(() {});
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data.location,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              formatted,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                  color: myconstants.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: myconstants.primaryColor.withOpacity(.5),
                      offset: const Offset(0, 25),
                      blurRadius: 10,
                      spreadRadius: -12,
                    )
                  ]),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -40,
                    left: 20,
                    child: Image.asset('assets/$image.png', width: 150),
                  ),
                  Positioned(
                      top: 20,
                      right: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "${widget.data.temperature}",
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                // foreground: Point()
                                //   ..shader = linearGradient,
                              ),
                            ),
                          ),
                          const Text(
                            'o',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              // foreground: Point()..shader = linearGradient,
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weatherItem(
                    text: 'Wind Speed',
                    value: widget.data.windSpeed,
                    unit: 'km/h',
                    imageUrl: 'assets/windspeed.png',
                  ),
                  weatherItem(
                      text: 'Humidity',
                      value: widget.data.humidity,
                      unit: '',
                      imageUrl: 'assets/humidity.png'),
                  weatherItem(
                    text: 'Max Temp',
                    value: widget.data.maxTemp,
                    unit: 'C',
                    imageUrl: 'assets/max-temp.png',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Next 7 Days',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: myconstants.primaryColor),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: consolidatedWeatherList.length,
                itemBuilder: (BuildContext context, int index) {
                  String today = DateTime.now().toString().substring(0, 10);
                  var selectedDay = today;
                  var futureWeatherName = image;
                  print(consolidatedWeatherList);
                  var parsedDate = DateTime.parse(
                      DateTime.now().add(const Duration(days: 1)).toString());
                  var newDate = DateFormat('EEEE')
                      .format(parsedDate)
                      .substring(0, 3); //formateed date

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    margin:
                        const EdgeInsets.only(right: 10, bottom: 10, top: 10),
                    width: 80,
                    decoration: BoxDecoration(
                        color: selectedDay == today
                            ? myconstants.primaryColor
                            : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 5,
                            color: selectedDay == today
                                ? myconstants.primaryColor
                                : Colors.black54.withOpacity(.2),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.data.temperature.round()}C",
                          style: TextStyle(
                            fontSize: 7,
                            color: selectedDay == today
                                ? Colors.white
                                : myconstants.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Image.asset(
                          'assets/$futureWeatherName.png',
                          width: 30,
                          height: 20,
                        ),
                        Text(
                          newDate,
                          style: TextStyle(
                            fontSize: 7,
                            color: selectedDay == today
                                ? Colors.white
                                : myconstants.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  );
                  // );
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
