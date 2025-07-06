import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deci_mate_decision_making_app/services/functions/auth_func.dart';

saveDecision(
  String title,
  List pollOptions,
  Map pollWeights,
  Map<String, int> usersWhoVoted,
) async {
  await FirebaseFirestore.instance.collection('decisions').add({
    'uid': currentUser!.uid,
    'title': title,
    'pollOptions': pollOptions,
    'usersWhoVoted': usersWhoVoted,
    'pollWeights': pollWeights,
  });
}
