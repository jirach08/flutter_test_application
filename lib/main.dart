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
      create: (context) => MyRoomStatesNotifier(10),
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
  String name = "";
  bool occupied = false;

  MyRoomState(this.id, this.name){ occupied = false; }

  void toggle() { occupied = !occupied; }
}

class MyRoomStatesNotifier extends ChangeNotifier {
  MyRoomStatesNotifier(this.nRooms){
    for (int i = 0; i < nRooms; i++) {
      rooms.add(MyRoomState(i, "Raum $i"));
    }  
  }

  int nRooms = 0;
  List<MyRoomState> rooms = [];
  
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
              onPressed: (){
                appState.toggle(room.id);
              },
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all<Color>(room.occupied ? Colors.deepOrange: Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: Text(room.name),
            ),
          ],
        ),
    );
  }
}