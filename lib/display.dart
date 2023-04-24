import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:holiday_project/app_state.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  int _currentPerson = 0;

  void incrementPerson(bool isForward) {
    int position = _currentPerson;

    if (isForward) {
      position++;
    } else {
      position--;
    }
    int peopleCount =
        Provider.of<AppState>(context, listen: false).people.length;

    setState(() {
      _currentPerson = position;
      if (_currentPerson > peopleCount - 1) {
        _currentPerson -= peopleCount;
      } else if (_currentPerson < 0) {
        _currentPerson += peopleCount;
      }

      print(_currentPerson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AppState>(
          builder: (context, appState, child) {
            return (appState.people.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title:
                                Text(appState.people[_currentPerson].firstName),
                            subtitle: Text(
                                "Age: ${appState.people[_currentPerson].age}"),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text('Has a mobile phone'),
                            trailing: Checkbox(
                              value: appState.people[_currentPerson].hasPhone,
                              onChanged: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Text('No people entered');
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => incrementPerson(false),
                child: const Text('Back'),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () => incrementPerson(true),
                child: const Text('Next'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
