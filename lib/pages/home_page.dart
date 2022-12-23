import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/components/my_alert_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // list for today's list
  List todaysHabitList = [
    //[habitname, habitCompleted]
    ["Morning Run", false],
    ["Read a book", false],
    ["Code an App", false],
  ];

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value!;
    });
  }

  // create a new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    // show alert dialog for user to enter new habit details
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertBox(
            controller: _newHabitNameController,
            onSave: saveNewHabit,
            onCancel: cancelNewHabit,
          );
        });
  }

// save new habit

  void saveNewHabit() {
    // add new habit to todayshabit list
    setState(() {
      todaysHabitList.add([_newHabitNameController.text, false]);
    });
    // clear text field
    _newHabitNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

// cancel new habit

  void cancelNewHabit() {
    // clear text field
    _newHabitNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      body: ListView.builder(
        itemCount: todaysHabitList.length,
        itemBuilder: ((context, index) {
          return HabitTile(
            habitName: todaysHabitList[index][0],
            habitCompleted: todaysHabitList[index][1],
            onChanged: (value) => checkBoxTapped(value, index),
          );
        }),
      ),
    );
  }
}
