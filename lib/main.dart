import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyRoomStatesNotifier(),
      child: MaterialApp(
        title: 'Meetly',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyRoomState{
  int id = 0;
  String name = "room0";
  bool occupied = false;

  MyRoomState(int id, String name){
    this.id = id;
    this.name = name;
    this.occupied = false;
  }

  void toggle(){
    occupied = !occupied;
  }
  Color get color {
    if (occupied) {
      return Colors.red;
    }
    else {
      return Colors.green;
    }
  }
}

class MyRoomStatesNotifier extends ChangeNotifier {
  var rooms = [for (int i in [0,1,2]) MyRoomState(i, "Raum $i")];
  void toggle(int i) {
    rooms[i].toggle();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyRoomStatesNotifier>();

    return Scaffold(
      body: Column(
        children: [
          for (var room in appState.rooms)
            ElevatedButton(
              child: Text(room.name),
              onPressed: (){
                appState.toggle(room.id);
              },
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all<Color>(room.color),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
            ),
          ],
        ),
    );
  }
}
