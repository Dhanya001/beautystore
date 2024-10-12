import 'package:flutter/material.dart';
import 'package:mansi_beauty_store/HomeScreen/HomePage.dart';
import 'package:mansi_beauty_store/Others/BottonNavigation.dart';
import 'package:mansi_beauty_store/auth/User_Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  int _currentIndex = 0;

  bool _isLoggedIn=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
        break;
      case 2:
      // Navigate to other pages as needed
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
    }
  }

  final List<Map<String, dynamic>> _dashboardItems = [
    {'title': 'Add Products', 'icon': Icons.add_box},
    {'title': 'Update Products', 'icon': Icons.update},
    {'title': 'Delete Products', 'icon': Icons.delete},
    {'title': 'Add Categories', 'icon': Icons.category},
    {'title': 'Users', 'icon': Icons.people},
    {'title': 'Comments', 'icon': Icons.comment},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: Color(0xffFF1694),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Admin Panel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings page
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _logout();
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: _dashboardItems.length,
        itemBuilder: (context, index) {
          final item = _dashboardItems[index];
          return GestureDetector(
            onTap: () {
              switch (item['title']) {
                /*case 'Add Products':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductPage(products: [],)),
                  );
                  break;*/
                case 'Update Products':
                // Add navigation for Update Products page
                  break;
                case 'Delete Products':
                // Add navigation for Delete Products page
                  break;
                case 'Add Categories':
                // Add navigation for Add Categories page
                  break;
                case 'Users':
                // Add navigation for Users page
                  break;
                case 'Comments':
                // Add navigation for Comments page
                  break;
              }
            },
            child: _buildGridItem(item),
          );
        },
      ),
      bottomNavigationBar:
      BottomNavigation(currentIndex: _currentIndex, onTap: _onTap),
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item['icon'], size: 40.0),
          SizedBox(height: 10.0),
          Text(
            item['title'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    setState(() {
      _isLoggedIn = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
