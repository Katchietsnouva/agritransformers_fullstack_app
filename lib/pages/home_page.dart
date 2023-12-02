import 'package:chatapp/components/my_app_bar.dart';
import 'package:chatapp/pages/items_upload_page.dart';
import 'package:chatapp/pages/market_place_page.dart';
import 'package:chatapp/pages/messages_page.dart';
import 'package:chatapp/pages/search_page.dart';
import 'package:chatapp/pages/user_profile_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_page.dart';
import 'home_posts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Sign user out
  void signOut() {
    // Get auth services
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  int currentPage = 0;

  void _updatePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPageWidget;
    if (currentPage == 1) {
      currentPageWidget = const MessagePage();
    } else if (currentPage == 2) {
      currentPageWidget = const SearchPage();
    } else if (currentPage == 3) {
      currentPageWidget =  const ItemsUploadScreen();
    } else if (currentPage == 4) {
      currentPageWidget = const MarketPlace();
    } else if (currentPage == 5) {
      currentPageWidget = UserProfile();
    } else {
      currentPageWidget = const HomePostsPage();
    }
    return Scaffold(
      appBar: MyAppBar(onSignOut: signOut), // Use the custom AppBar
      // Your content here
      body: currentPageWidget,
      // body: currentPage == 1 ? const MessagePage() : const HomePostsPage(),
      // body: currentPage == 2 ? const SearchPage() : const HomePostsPage(),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.home,
                color: currentPage == 0 ? Colors.green : Colors.black,
              ),
              onPressed: () {
                _updatePage(0);
              },
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.message_outlined,
                color: currentPage == 1 ? Colors.green : Colors.black,
              ),
              onPressed: () {
                _updatePage(1);
              },
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.search,
                color: currentPage == 2 ? Colors.green : Colors.black,
              ),
              onPressed: () {
                _updatePage(2);
              },
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.ondemand_video,
                color: currentPage == 3 ? Colors.green : Colors.black,
              ),
              onPressed: () {
                _updatePage(3);
              },
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.card_travel,
                color: currentPage == 4 ? Colors.green : Colors.black,
              ),
              onPressed: () {
                _updatePage(4);
              },
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.person,
                color: currentPage == 5 ? Colors.green : Colors.black,
              ),
              onPressed: () {
                _updatePage(5);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// import 'package:chatapp/services/auth/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   //Sign user out
//   void signOut() {
//     //get auth services
//     final authService = Provider.of<AuthService>(context, listen: false);
//     authService.signOut();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//         actions: [
//           //Sign out Button
//           IconButton(
//             onPressed: signOut,
//             icon: const Icon(Icons.logout),
//           )
//         ],
//       ),
//     );
//   }
// }
