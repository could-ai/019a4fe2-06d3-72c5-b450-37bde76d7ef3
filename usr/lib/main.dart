import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Q&A App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const QaScreen(),
    );
  }
}

class QaScreen extends StatefulWidget {
  const QaScreen({super.key});

  @override
  State<QaScreen> createState() => _QaScreenState();
}

class _QaScreenState extends State<QaScreen> {
  final TextEditingController _questionController = TextEditingController();
  String _answer = '';
  bool _isLoading = false;

  // A simple map to store questions and answers
  final Map<String, String> _qaMap = {
    "hello": "Hello! How can I help you today?",
    "how are you?": "I am a bot, but I'm doing great! Thanks for asking.",
    "what is flutter?": "Flutter is an open-source UI software development kit created by Google. It is used to develop cross-platform applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia, and the web from a single codebase.",
    "who are you?": "I am a simple Q&A bot created to help you.",
  };

  void _getAnswer() async {
    final question = _questionController.text.trim().toLowerCase();
    if (question.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _answer = '';
    });

    // Simulate a network call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _answer = _qaMap[question] ?? "Sorry, I don't have an answer for that. Please try another question.";
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Me Anything'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ask a question...',
              ),
              onSubmitted: (_) => _getAnswer(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _getAnswer,
              child: const Text('Get Answer'),
            ),
            const SizedBox(height: 32.0),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_answer.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  _answer,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
