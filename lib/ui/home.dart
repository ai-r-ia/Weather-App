import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/city.dart';
import 'package:weather/model/constants.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/services/weather_api.dart';
import 'package:weather/ui/weather_item.dart';

class Home extends StatefulWidget {
  final Weather data;
  const Home({Key? key, required this.data}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myconstants = Constants();
  WeatherApiClient client = WeatherApiClient();
  var selectedCities = City.getSelectedCities();
  List<String> cities = ['Delhi'];
  // List consolidatedWeatherList = [];
  String imageUrl = '';

  // Future<void> getData() async {
  //   data = await client.getCurrentWeather(cities[0]);
  //   // consolidatedWeatherList =
  //   // await client.getCurrentWeather(widget.data.location)?.toSet().toList();
  // }

  // imageUrl = weatherStateName
  //         .replaceAll(' ', '')
  //         .toLowerCase();

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

  // String windSpeed = data?.windSpeed.toString() ?? "no data";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                        onChanged: (String? newValue) {
                          setState(() async {
                            widget.data.location = newValue!;
                            await client
                                .getCurrentWeather(widget.data.location);
                          });
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
                    child: imageUrl == ''
                        ? const Text('')
                        : Image.asset('assets/' + imageUrl + '.png',
                            width: 150),
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
              height: 50,
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
                    text: 'Wind Speed',
                    value: widget.data.maxTemp,
                    unit: 'C',
                    imageUrl: 'assets/max-temp.png',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Next 7 Days',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: myconstants.primaryColor),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Expanded(
            //     child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: consolidatedWeatherList.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           String today = DateTime.now().toString().substring(0, 10);
            //           var selectedDay =
            //               consolidatedWeatherList[index]['applicable_date'];
            //           var futureWeatherName =
            //               consolidatedWeatherList[index]['weather_state_name'];
            //           var weatherUrl =
            //               futureWeatherName.replaceAll(' ', '').toLowerCase();

            //           var parsedDate = DateTime.parse(
            //               consolidatedWeatherList[index]['applicable_date']);
            //           var newDate = DateFormat('EEEE')
            //               .format(parsedDate)
            //               .substring(0, 3); //formateed date

            //           return GestureDetector(
            //             onTap: () {
            //               Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(consolidatedWeatherList: consolidatedWeatherList, selectedId: index, location: widget.data.location,)));
            //             },
            //             child: Container(
            //               padding: const EdgeInsets.symmetric(vertical: 20),
            //               margin: const EdgeInsets.only(
            //                   right: 20, bottom: 10, top: 10),
            //               width: 80,
            //               decoration: BoxDecoration(
            //                   color: selectedDay == today
            //                       ? myconstants.primaryColor
            //                       : Colors.white,
            //                   borderRadius:
            //                       const BorderRadius.all(Radius.circular(10)),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       offset: const Offset(0, 1),
            //                       blurRadius: 5,
            //                       color: selectedDay == today
            //                           ? myconstants.primaryColor
            //                           : Colors.black54.withOpacity(.2),
            //                     ),
            //                   ]),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(
            //                     consolidatedWeatherList[index]['the_temp']
            //                             .round()
            //                             .toString() +
            //                         "C",
            //                     style: TextStyle(
            //                       fontSize: 17,
            //                       color: selectedDay == today
            //                           ? Colors.white
            //                           : myconstants.primaryColor,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                   Image.asset(
            //                     'assets/' + weatherUrl + '.png',
            //                     width: 30,
            //                   ),
            //                   Text(
            //                     newDate,
            //                     style: TextStyle(
            //                       fontSize: 17,
            //                       color: selectedDay == today
            //                           ? Colors.white
            //                           : myconstants.primaryColor,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           );
            //         }))

            // const Text(
            //   'Wind Speed',
            //   style: TextStyle(
            //     color: Colors.black54,
            //   ),
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            // Container(
            //   padding: const EdgeInsets.all(10.0),
            //   height: 60,
            //   width: 60,
            //   decoration: const BoxDecoration(
            //     color: Color(0xffE0E8F8),
            //     borderRadius: BorderRadius.all(Radius.circular(15)),
            //   ),
            //   child: Image.asset('assets/windspeed.png'),
            // ),
            // Text(data?.windSpeed.toString() = data?.windSpeed.toString() ?? "no data";)
            // ],
            // ),
            // )
          ],
        ),
      ),
    );
  }
}
