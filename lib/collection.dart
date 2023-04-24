import 'package:flutter/material.dart';
import 'package:holiday_project/app_state.dart';
import 'package:provider/provider.dart';

class Collection extends StatefulWidget {
  const Collection({super.key});

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  int? _age;
  bool _hasPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'First Name',
                hintText: 'Enter your first name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
              onSaved: (value) {
                _firstName = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                hintText: 'Enter your age',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onSaved: (value) {
                _age = int.parse(value!);
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _hasPhoneNumber,
                  onChanged: (value) {
                    setState(() {
                      _hasPhoneNumber = value!;
                    });
                  },
                ),
                const Text('Do you have a mobile phone?'),
              ],
            ),
            const SizedBox(height: 32),
            Consumer<AppState>(
              builder: (context, appState, child) => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      People person =
                          People(_firstName!, _age!, _hasPhoneNumber);
                      appState.addPerson(person);
                      _formKey.currentState?.reset();
                      setState(() {
                        _hasPhoneNumber = false;
                      });
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
