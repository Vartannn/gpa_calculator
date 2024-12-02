



import 'package:flutter/material.dart';
import 'calculator.dart';

class GPAHomePage extends StatefulWidget {
  const GPAHomePage({super.key});

  @override
  _GPAHomePageState createState() => _GPAHomePageState();
}

class _GPAHomePageState extends State<GPAHomePage> {
  final List<TextEditingController> _gradeControllers = [];
  final List<int> _creditSelections = [];
  double? _gpa;
  TextEditingController _nameController = TextEditingController();
  String? _nameErrorMessage;
  List<String?> _gradeErrorMessages = [];

  void _addCourse() {
    setState(() {
      _gradeControllers.add(TextEditingController());
      _creditSelections.add(1);
      _gradeErrorMessages.add(null);
    });
  }

  void _resetFields() {
    setState(() {
      _gradeControllers.clear();
      _creditSelections.clear();
      _gpa = null;
      _nameController.clear();
      _nameErrorMessage = null;
      _gradeErrorMessages.clear();
    });
  }

  void _calculateGPA() {
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameErrorMessage = 'Please enter your name before calculating GPA.';
      });
      return;
    }

    bool hasError = false;

    for (int i = 0; i < _gradeControllers.length; i++) {
      String? grade = _gradeControllers[i].text;
      if (grade.isEmpty || int.tryParse(grade) == null || int.parse(grade) < 0 || int.parse(grade) > 100) {
        setState(() {
          _gradeErrorMessages[i] = 'Please enter a valid grade (0-100).';
        });
        hasError = true;
      } else {
        setState(() {
          _gradeErrorMessages[i] = null;
        });
      }
    }

    if (hasError) return;

    setState(() {
      _nameErrorMessage = null;
      _gpa = calculateGPA(_gradeControllers, _creditSelections);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Enter your name:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                errorText: _nameErrorMessage,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter your grades and select credits for each course:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _gradeControllers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _gradeControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Grade (0-100)',
                                errorText: _gradeErrorMessages[index],
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton<int>(
                            value: _creditSelections[index],
                            items: const [
                              DropdownMenuItem<int>(
                                value: 1,
                                child: Text('1 Credit (Lab Course)'),
                              ),
                              DropdownMenuItem<int>(
                                value: 3,
                                child: Text('3 Credits (Normal Course)'),
                              ),
                            ],
                            onChanged: (newValue) {
                              setState(() {
                                _creditSelections[index] = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addCourse,
              child: const Text('Add Course'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateGPA,
              child: const Text('Calculate GPA'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetFields,
              child: const Text('Reset'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            if (_gpa != null)
              Text(
                '${_nameController.text}, your GPA is ${_gpa!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            if (_gpa == null && _gradeControllers.isNotEmpty)
              const Text(
                'Please check your input values. Grades should be between 0 and 100, and credits should be valid.',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}