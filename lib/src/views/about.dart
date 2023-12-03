import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/.JPG'),
                backgroundColor: Colors.lightBlueAccent,
              ),
              SizedBox(height: 20),
              Text(
                'Flutter Enthusiast',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'A pro attitude, excellent communication skills and the highest code quality, then I\'m the person looking for. Over the last 10 years I\'ve built many apps of several fields for Android and Flutter apps. Principles As a freelancer, take great pride in making sure all of projects are up to client\'s satisfaction, all deadlines are met and quality assurance is carefully considered.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email: contact@example.com', style: TextStyle(fontSize: 17),),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone: +123 456 7890', style: TextStyle(fontSize: 17),),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Text(
                'Follow Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.facebook),
                    onPressed: () {
                      // Add your Facebook link handling logic
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.twitter),
                    onPressed: () {
                      // Add your Twitter link handling logic
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.linkedin),
                    onPressed: () {
                      // Add your LinkedIn link handling logic
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}