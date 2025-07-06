import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deci_mate_decision_making_app/widgets/show_poll_card.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('decisions')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      final docs = snapshot.data!.docs;
                      Map<String, int> usersWhoVoted = {};

                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          docs[index]['usersWhoVoted'].forEach((key, value) {
                            usersWhoVoted[key] = value;
                          });
                          return ShowPollCard(
                            creatorId: docs[index]['uid'],
                            decisionId: docs[index].id,
                            decisionTitle: docs[index]['title'],
                            pollOptions: docs[index]['pollOptions'],
                            pollWeights: docs[index]['pollWeights'],
                            usersWhoVoted: usersWhoVoted,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
