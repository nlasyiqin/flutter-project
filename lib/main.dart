// import 'dart:html';
import 'package:api_try/post_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const postAPI()
      // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}




class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String? stringResponse;
Map? mapResponse; 
Map? dataResponse;
List? listResponse;
//list untuk displaykan json data yang ada banyak list tu

  Future apicall() async{
    http.Response response;
    // response = await http.get(Uri.parse("https://reqres.in/api/users/2"));
    //ni untuk amik link untuk get single kat reqres.in
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    //ni link contoh untuk users list kat reqres.in
    if( response.statusCode == 200) {
      setState(() {
        //stringResponse = response.body;
        mapResponse = json.decode(response.body);
        //dataResponse = mapResponse?["data"];
        listResponse = mapResponse?["data"];
        //kalau nak display data(nama) punya data. 
        //kalau display support(nama), tulis support
        //akan effect yang didisplay kat bawah (bhgian child=dataresponse)
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
    
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
  
        title: Text(widget.title),
      ),
      body: Center(
       
        child: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.blueGrey),
          child: Center(
            child: Column(
              children: [
                // dataResponse == null? Text("Data is loading"): Text('Last name: ${dataResponse!['last_name'].toString()}'),
                dataResponse == null? Text("Data is loading"): Text(dataResponse![0]['last_name'].toString()),
                Text('Email: ${dataResponse!['email'].toString()}'),
                //kalau nak buat Email: data
                Text(dataResponse!['first_name'].toString()),
                Text(dataResponse!['last_name'].toString())
              ],
            ),
            //utk display specific detail dalam support/data punya data

            //child: mapResponse == null? Text("Data is loading"): Text(mapResponse['support'].toString()),
            //utk display data2 dalam support data
            //["data"] can be written if want to get data from data, otherwise, write support (both are name of data)
            //refer to json data ( what u want to get)
          ),

        ),   
          
        ),
      );
       // This trailing comma makes auto-formatting nicer for build methods.
    
  }
}
