import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



Future<TrainBetweenStations> fetchTrainBetweenStation() async {
  var uri = Uri.https('irctc1.p.rapidapi.com','/api/v2/trainBetweenStations',
      {"fromStationCode": "bju", "toStationCode": "bdts"});

  final response = await http.get(uri, headers: {
    "X-RapidAPI-Key": "f2c2f9585bmshc0d5bd98f16741cp1fcefejsnb2811797cf73",
    "X-RapidAPI-Host": "irctc1.p.rapidapi.com",
    "useQueryString": "true"
  });

    // Send authorization headers to the backend.

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return TrainBetweenStations.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Nahi hua Bhaiya');
  }

  final responseJson = jsonDecode(response.body);

  return TrainBetweenStations.fromJson(responseJson);
}

class TrainBetweenStations{
  final String distance;
  final String train_destination_station_code;
  final String depart_time;
  final String arrival_time;
  final String train_number;

  TrainBetweenStations({
    required this.train_number,
    required this.train_destination_station_code,
    required this.arrival_time,
    required this.depart_time,
    required this.distance,});

  factory TrainBetweenStations.fromJson(Map<String, dynamic> json) {
    return TrainBetweenStations(
      distance: json['distance'] as String,
      train_number: json['train_number'] as String,
      train_destination_station_code: json['train_destination_station_code'] as String,
      arrival_time: json['arrival_time'] as String,
      depart_time: json['depart_time'] as String,);
  }
}



class homepg extends StatefulWidget {
  const homepg({super.key});

  @override
  State<homepg> createState() => _homepgState();

}

class _homepgState extends State<homepg> {
  late Future<TrainBetweenStations> futureTrainBetweenStations;



  @override
  void initState() {
    super.initState();
    futureTrainBetweenStations = fetchTrainBetweenStation();

    fetchTrainBetweenStation();
  }

  final _textController1 = TextEditingController();
  String fsc = '';
  String tsc = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text("BOOK TICKET"
            )
        ),
      ),
      body:
      Column(
        children: [
          FutureBuilder<TrainBetweenStations>(
            future: futureTrainBetweenStations,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.train_destination_station_code);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: _textController1,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.train),
                    hintText: "From",
                    border: OutlineInputBorder(),
                  ),),
                Icon(Icons.swap_vert),
                const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_on_outlined),
                    hintText: "To",
                    border: OutlineInputBorder(),
                  ),),
              ],),
          ),
        ],
      ),
    );
  }
}
