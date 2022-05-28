import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather/model/constants.dart';
import 'package:weather/ui/welcome.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constants myconstants = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: myconstants.primaryColor.withOpacity(0.5),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/get-started.png'),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Welcome()));
              },
              child: Container(
                height: 50,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: myconstants.primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
