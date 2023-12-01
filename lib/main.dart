import 'package:english_words/english_words.dart';
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
        title: 'Namer App',
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
}

class MyRoomStatesNotifier extends ChangeNotifier {
  var rooms = [for (int i in [0,1,2]) MyRoomState(i, "room$i")];

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
          for (var room in context.rooms)
            ElevatedButton(
              child: Text(room.name),
              onPressed: (){
                appState.toggle(room.id);
              },
            ),
          ],
        ),
    );
  }
}
