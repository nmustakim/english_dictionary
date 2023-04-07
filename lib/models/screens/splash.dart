import 'package:english_to_english_dictionary/models/screens/dictionary_home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    toHome();
  }

  void toHome() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const DictionaryHome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.deepPurple,
          ),
          Container(
            height: 420,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(250))),
          ),
          const Positioned(
              top: 190,
              left: 65,
              child: SizedBox(
                height: 250,
                width: 350,
                child: Text(
                  'English Dictionary',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                ),
              )),
          const Positioned(top:320,left:85,child: Text('Definition,Parts of speech etc...',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}
