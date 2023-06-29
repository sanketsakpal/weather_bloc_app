import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String? city;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void onSubmit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      form.save();
      Navigator.pop(context, city!.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                autofocus: true,
                style: const TextStyle(fontSize: 18.0),
                decoration: const InputDecoration(
                  labelText: 'City name',
                  hintText: "more than 2 char",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                validator: (String? input) {
                  if (input == null || input.trim().length < 2) {
                    return 'city name must be at least 2 characters log';
                  }
                  return null;
                },
                onSaved: (String? input) {
                  city = input;
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  onSubmit();
                },
                child: const Text(
                  "how's weather?",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
