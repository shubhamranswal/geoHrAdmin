import 'package:flutter/material.dart';
import 'package:geo_attendance_system_hr/constants/colors.dart';
import 'package:geo_attendance_system_hr/services/authentication.dart';
import 'package:geo_attendance_system_hr/ui/adduser.dart';
import 'package:geo_attendance_system_hr/ui/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Auth authObj = Auth();
  int _selectedDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 25),
              color: dashBoardColor,
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text("Account Name",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                    padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                  ),
                  Center(
                    child: Text("Account Email",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () => setState(() {
                      _selectedDrawerIndex = 0;
                      Navigator.pop(context);
                    }),
                  ),
                  Divider(),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text(
                      'Add New Employee',
                    ),
                    onTap: () => setState(() {
                      _selectedDrawerIndex = 1;
                      Navigator.pop(context);
                    }),
                  ),
                  Divider(),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: dashBoardColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
            onPressed: _logOut,
          ),
        ],
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeFragment();
      case 1:
        return AddUser();
    }
  }

  void _logOut() async {
    await authObj.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }
}

class HomeFragment extends StatefulWidget {
  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("HOME"),
    );
  }
}
