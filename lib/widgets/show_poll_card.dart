import 'package:better_polls/better_polls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deci_mate_decision_making_app/services/functions/auth_func.dart';
import 'package:deci_mate_decision_making_app/utils/colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_polls/flutter_polls.dart';

class ShowPollCard extends StatefulWidget {
  final String decisionId, decisionTitle, creatorId;
  final List pollOptions;
  final Map pollWeights;
  final Map<String, int> usersWhoVoted;

  const ShowPollCard({
    super.key,
    required this.decisionId,
    required this.decisionTitle,
    required this.creatorId,
    required this.pollOptions,
    required this.usersWhoVoted,
    required this.pollWeights,
  });

  @override
  State<ShowPollCard> createState() => _ShowPollCardState();
}

class _ShowPollCardState extends State<ShowPollCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Card(
        shadowColor: Colors.grey.shade600.withValues(alpha: 0.2),
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            width: 1,
            color: Colors.grey.shade600.withValues(alpha: 0.3),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.decisionTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Polls(
                iconColor: Colors.black87,
                children: [
                  for (
                    int i = 0;
                    i < widget.pollWeights.keys.toList().length;
                    i++
                  )
                    Polls.options(
                      title: widget.pollWeights.keys.toList()[i],
                      value: widget.pollWeights.values.toList()[i].toDouble(),
                    ),
                ],
                allowCreatorVote: true,
                // question: const Text(''),
                voteData: widget.usersWhoVoted,
                currentUser: currentUser!.uid,
                creatorID: widget.creatorId,

                userChoice: widget.pollOptions.indexOf(
                  widget.usersWhoVoted[widget.decisionId],
                ),
                onVoteBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                leadingBackgroundColor: AppColors.primary.withValues(
                  alpha: 0.6,
                ),
                backgroundColor: Colors.transparent,
                borderWidth: 1,
                onVoteBorderColor: Colors.grey.shade600.withValues(alpha: 0.3),
                voteCastedBackgroundColor: AppColors.primary.withValues(
                  alpha: 0.1,
                ),

                onVote: (choice) async {
                  Map userWhoVoted = widget.usersWhoVoted;
                  Map thisPollWeight = widget.pollWeights;

                  var selectedOption = widget.pollWeights.keys.toList()[choice];
                  setState(() {
                    //updating poll weights
                    thisPollWeight[selectedOption] =
                        thisPollWeight[selectedOption] + 1;

                    //updating people who voted in map with their choice
                    userWhoVoted[currentUser!.uid] =
                        widget.pollWeights.keys.toList().indexOf(
                          selectedOption,
                        ) +
                        1;
                  });

                  //update firestore
                  await FirebaseFirestore.instance
                      .collection('decisions')
                      .doc(widget.decisionId)
                      .update({
                        'pollWeights': thisPollWeight,
                        'usersWhoVoted': userWhoVoted,
                      });
                },
              ),

              // Polls(
              //   iconColor: Colors.black87,
              //   children: [
              //     for (
              //       int i = 0;
              //       i < widget.pollWeights.keys.toList().length;
              //       i++
              //     )
              //       Polls.options(
              //         title: widget.pollWeights.values.toList()[i],
              //         value: (widget.pollWeights.keys.toList()[i]).toDouble(),
              //       ),
              //   ],
              //   allowCreatorVote: true,
              //   question: const Text(''),
              //   onVoteBorderColor: AppColors.primary,
              //   voteData: widget.usersWhoVoted,
              //   currentUser: currentUser!.uid,
              //   creatorID: widget.creatorId,
              //   leadingBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
              //   userChoice: widget.pollWeights.keys.toList().indexOf(
              //     widget.usersWhoVoted[widget.decisionId],
              //   ),
              //   onVoteBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
              //   backgroundColor: Colors.transparent,

              //   onVote: (choice) async {
              //     Map userWhoVoted = widget.usersWhoVoted;
              //     Map thisPollWeight = widget.pollWeights;

              //     var selectedOption = widget.pollWeights.keys
              //         .toList()[choice - 1];
              //     setState(() {
              //       //updating poll weights
              //       thisPollWeight[selectedOption] =
              //           thisPollWeight[selectedOption] + 1;

              //       //updating people who voted in map with their choice
              //       userWhoVoted[currentUser!.uid] = widget.pollWeights.keys
              //           .toList()[choice - 1];
              //     });

              //     //update firestore
              //     await FirebaseFirestore.instance
              //         .collection('decisions')
              //         .doc(widget.decisionId)
              //         .update({
              //           'pollWeights': thisPollWeight,
              //           'usersWhoVoted': userWhoVoted,
              //         });
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
