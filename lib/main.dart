import 'package:bc_info/Screens/user_main.dart';
import 'package:bc_info/Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initilization =
      Firebase.initializeApp(); //firebase
  // const MyApp({Key? key}) : super(key: key);

  /////////////////////keep login
  final storage = new FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value == null) {
      return false;
    }
    return true;
  } //keep login

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /////////////////////////////Firebase ///////////////////////
    return FutureBuilder(
        future: _initilization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //////////////////////////////
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // home: WelcomeScreen(),
            home: FutureBuilder(
                future: checkLoginStatus(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data == false) {
                    return WelcomeScreen();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return UserMainState();
                }),
          );
        });
  }
}
