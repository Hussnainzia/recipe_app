import 'package:flutter/material.dart';
import 'package:loginapplication/screens/recipe_input_screen.dart'; // Import the RecipeInputScreen

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // You can add navigation to the Profile screen here if needed
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfileScreen()),
                // );
              },
            ),
            // Add more items here if needed
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Main Screen!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to RecipeInputScreen when button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipeInputScreen()),
                );
              },
              child: Text('Go to Recipe Generator'),
            ),
          ],
        ),
      ),
    );
  }
}
