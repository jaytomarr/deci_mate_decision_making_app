// import 'package:deci_mate_decision_making_app/services/functions/auth_func.dart';
import 'package:deci_mate_decision_making_app/services/providers/poll_provider.dart';
import 'package:deci_mate_decision_making_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPollForm extends StatefulWidget {
  const AddPollForm({super.key});

  @override
  State<AddPollForm> createState() => _AddPollFormState();
}

class _AddPollFormState extends State<AddPollForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PollProvider>(
      builder: (_, model, __) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey.shade600.withValues(alpha: 0.3),
            ),
          ),
          elevation: 0,
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Add Poll Title',
                    hintStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 2,
                  cursorColor: AppColors.primary,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Title';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    model.addPollTitle(value!);
                  },
                ),
                Column(
                  children: [
                    for (int i = 0; i < model.pollOptions.length; i++)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Option',
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Option';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  model.pollOptions[i] = value;
                                  model.pollWeights[value] = 0;
                                  model.usersWhoVoted = {};
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                model.removeOption(i);
                              },
                              icon: Icon(
                                Icons.close_rounded,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        model.addPollOption();
                      },
                      child: Text(
                        'Add Option',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
