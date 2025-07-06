import 'package:deci_mate_decision_making_app/services/functions/firebase_func.dart';
import 'package:deci_mate_decision_making_app/services/providers/poll_provider.dart';
import 'package:deci_mate_decision_making_app/utils/colors.dart';
import 'package:deci_mate_decision_making_app/widgets/add_poll_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDecision extends StatefulWidget {
  const AddDecision({super.key});

  @override
  State<AddDecision> createState() => _AddDecisionState();
}

class _AddDecisionState extends State<AddDecision> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PollProvider>(
        builder: (context, model, child) {
          return Container(
            padding: EdgeInsets.all(14),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AddPollForm(),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.primary,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          saveDecision(
                            model.pollTitle,
                            model.pollOptions,
                            model.pollWeights,
                            model.usersWhoVoted,
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Decision Uploaded')),
                        );
                      },
                      child: Text(
                        'Add Decision',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
