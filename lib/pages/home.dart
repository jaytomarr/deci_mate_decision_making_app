import 'package:deci_mate_decision_making_app/pages/add_decision.dart';
import 'package:deci_mate_decision_making_app/pages/dashboard.dart';
// import 'package:deci_mate_decision_making_app/services/providers/poll_provider.dart';
import 'package:deci_mate_decision_making_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    // Provider.of<PollProvider>(context, listen: false).reset();
    setState(() {
      selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeciMate'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [Dashboard(), AddDecision()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: 'Add Decision',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey.shade700,
        onTap: onTapped,
      ),
    );
  }
}
