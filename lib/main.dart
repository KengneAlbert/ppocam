import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_thingspeak/flutter_thingspeak.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double currentTemperature = 0.0; 
  double currentAliment = 0.0; 
  double currentWatter = 0.0; 
  final flutterThingspeak = FlutterThingspeakClient(channelID: '2502018');

  
  @override
  void initState() {
    super.initState();
    flutterThingspeak.initialize();
    _getTemperatureData(); 
  }

  Future<void> _getTemperatureData() async {
    
    final result = await flutterThingspeak.getAllData();
    
    final lastTemperature = result['feeds'].last['field1'];
    final lastAliment = result['feeds'].last['field3'];
    final lastWatter = result['feeds'].last['field4'];
    if (result.isNotEmpty) {

      setState(() {
        currentTemperature = double.parse(lastTemperature);
        currentAliment = double.parse(lastAliment);
        currentWatter = double.parse(lastWatter);
      });
    }
  }

 


  // void sendDataToThingSpeak() async {
    
  //   final response = await http.get(Uri.parse('https://api.thingspeak.com/update?api_key=1FQSY5RJU8LLBVVE&field1=0'),);
  //   if (response.statusCode == 200) {
  //     print('Données envoyées avec succès');
  //   } else {
  //     print('Échec de l\'envoi des données');
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomePage(currentTemperature: currentTemperature, currentAliment: currentAliment, currentWatter: currentWatter),
    );
  }

}

class HomePage extends StatelessWidget {

  final double currentTemperature;
  final double currentAliment;
  final double currentWatter;
  final String writeApiKey = "VF62T8KFTMBPTEXJ";

  const HomePage({super.key, required this.currentTemperature, required this.currentAliment, required this.currentWatter});

   Future<void> sendWatterToThingSpeak(String apiKey, int field1Value) async {
      final response = await http.get(
        Uri.parse('https://api.thingspeak.com/update?api_key=$apiKey&field1=$field1Value'),
      );

      if (response.statusCode == 200) {
        print('Données envoyées avec succès');
      } else {
        print('Échec de l\'envoi des données');
      }
   }

   Future<void> sendAlimentToThingSpeak(String apiKey, int field1Value) async {
      final response = await http.get(
        Uri.parse('https://api.thingspeak.com/update?api_key=$apiKey&field1=$field1Value'),
      );

      if (response.statusCode == 200) {
        print('Données envoyées avec succès');
      } else {
        print('Échec de l\'envoi des données');
      }
   }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with cards
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Visualiser les activites de votre ferme',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      height: 100,
                      child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // Example card
                        Container(
                          margin: const EdgeInsets.only(left: 65, bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                  ),
                                  child: Card(
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Icon(Icons.child_care, color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nombre de poules',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '24000',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    )
                  ),
                ],
              ),

              // Statistics section
              Padding(
                padding: const EdgeInsets.only(left:16.0, top:0.0),
                child: Text(
                  'Statistiques',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularPercentIndicator(
                                radius: 70,
                                lineWidth: 12,
                                percent: currentAliment / 200,
                                progressColor: Colors.white,
                                backgroundColor: Colors.white54,
                              ),
                              CircularPercentIndicator(
                                radius: 50,
                                lineWidth: 12,
                                percent: currentWatter / 100,
                                progressColor: Colors.yellow,
                                backgroundColor: Colors.white54,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24,
                      thickness: 1,
                      color: Color(0xFF6AA3B8),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Niveau d\'aliments restant',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Text(
                      'Niveau d\'eau',
                      style: TextStyle(color: Colors.yellow[300], fontSize: 20),
                    ),
                  ],
                ),
              ),

              // Temperature section
              Container(
                margin: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 16, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Temparature',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'ci-apres la temperature actuelle',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: Card(
                                  color: Color(0xFFE0E3E7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: FaIcon(
                                      FontAwesomeIcons.temperatureHigh,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: LinearPercentIndicator(
                            
                            // percent: currentTemperature / 50,
                            percent: currentTemperature / 100,
                            width: MediaQuery.of(context).size.width * 0.82,
                            lineHeight: 16,
                            progressColor: Colors.blue,
                            backgroundColor: Colors.grey[300],
                            barRadius: Radius.circular(24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Action buttons
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        sendWatterToThingSpeak(writeApiKey, 50);
                      },
                      child: Text('Charger l\'eau'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        sendAlimentToThingSpeak(writeApiKey, 50);
                      },
                      child: Text('Charger l\'aliment'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}