import 'package:bc_info/Screens/changepassword.dart';
import 'package:bc_info/Screens/dashboard.dart';
import 'package:bc_info/Screens/login_screen.dart';
import 'package:bc_info/Screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserMainState extends StatefulWidget {
  const UserMainState({Key? key}) : super(key: key);

  @override
  State<UserMainState> createState() => _UserMainStateState();
}

class _UserMainStateState extends State<UserMainState> {
  final storage = new FlutterSecureStorage();

  int _selectIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    DashBoardScreen(),
    Profile(),
    ChangePassword(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Welcome User"),
            IconButton(
              onPressed: () async => {
                await FirebaseAuth.instance.signOut(),
                await storage.delete(key: "uid"),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false),
              },
              icon: Icon(
                FontAwesomeIcons.powerOff,
                size: 20,
              ),
              tooltip: "Logout",
            ),

            // ElevatedButton(
            //   onPressed: () async => {
            //     await FirebaseAuth.instance.signOut(),
            //     await storage.delete(key: "uid"),

            //     Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(builder: (_) => LoginScreen()),
            //         (route) => false),
            //   },
            //   child: Text("Logout"),
            //   style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            // ),
          ],
        ),
        backgroundColor: Color(0xff08296c),
      ),

      ///////////////////////////////////////////////////
      body: _widgetOptions.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xff08296c),
            ),
            label: 'DashBoard',
          ),
          /////////////////////////////////////
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color(0xff08296c),
            ),
            label: 'My Profile',
          ),
          ///////////////////////////////////
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Color(0xff08296c),
            ),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Color(0xff2891cf),
        onTap: _onItemTapped,
      ),
    );
  }
}
