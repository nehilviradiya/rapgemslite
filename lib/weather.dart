import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

void main()
{
  MaterialApp(home: weather(),);
}

class weather extends StatefulWidget {
  const weather({super.key});

  @override
  State<weather> createState() => _weatherState();
}

class _weatherState extends State<weather> {

  static const apikey = "8f2a10e512bca468f1e734da9982b623";
  final WeatherFactory wf = WeatherFactory(apikey);
  Weather? weathger;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    wf.currentWeatherByCityName("surat").then((value) {
      setState(() {
        weathger = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child:  Text("${weathger!.areaName}" ),),);
  }
}
