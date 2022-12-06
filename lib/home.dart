import 'package:flutter/material.dart';
import 'package:poconboarding/models/select_option.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SelectOption dropValueDefault = ambients.first;
  SelectOption dropValueDefaultTopic = topics.first;
  String url = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Ambientes",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              DropdownButton<SelectOption>(
                  value: dropValueDefault,
                  items: ambients.map<DropdownMenuItem<SelectOption>>(
                      (SelectOption option) {
                    return DropdownMenuItem<SelectOption>(
                      value: option,
                      child: Text(option.label),
                    );
                  }).toList(),
                  onChanged: (changeValue) {
                    setState(() {
                      if (changeValue != null) {
                        dropValueDefault = changeValue;
                      }
                    });
                  }),
              const SizedBox(
                height: 32,
              ),
              const Text(
                "Assuntos",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              DropdownButton<SelectOption>(
                  value: dropValueDefaultTopic,
                  items: topics.map<DropdownMenuItem<SelectOption>>(
                      (SelectOption option) {
                    return DropdownMenuItem<SelectOption>(
                      value: option,
                      child: Text(option.label),
                    );
                  }).toList(),
                  onChanged: (changeValue) {
                    setState(() {
                      if (changeValue != null) {
                        dropValueDefaultTopic = changeValue;
                      }
                    });
                  }),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  onPressed: () {
                    String urlCompleted =
                        dropValueDefault.value + dropValueDefaultTopic.value;
                    setState(() {
                      url = urlCompleted;
                    });
                  },
                  child: const Text("Setar URL")),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    color: Colors.amber[100], child: Text("URL: $url")),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed("/inapp", arguments: {"url": url});
                  },
                  child: const Text("Abri Webview Lite")),
            ],
          ),
        ),
      ),
    );
  }
}
