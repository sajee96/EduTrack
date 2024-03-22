import 'package:edu_track/Onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  String fullName = '';
  String email = '';
  DateTime? dob;
  String? selectedSubject;
  String? locationName;
  bool marketingUpdates = false;
  bool correspondenceInWelsh = false;

  final List<String> subjects = [
    'Computer Programming',
    'Data Structures and Algorithms',
    'Software Engineering',
    'Artificial Intelligence',
    'Cybersecurity',
  ];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/create-student'), 
          body: {
            'fullName': fullName,
            'email': email,
            'dob': dob.toString(),
            'selectedSubject': selectedSubject!,
            'locationName': locationName!,
            'marketingUpdates': marketingUpdates.toString(),
            'correspondenceInWelsh': correspondenceInWelsh.toString(),
          },
        );

        if (response.statusCode == 200) {
          // Successful submission
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Successfully submitted'),
                actions: [
                  TextButton(
                    onPressed: () {
                                // Navigate to another page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const OnboardingView()),
                                );
                              },
                    child: Text('Return to Home'),
                  ),
                ],
              );
            },
          );
        } else {
          throw Exception('Failed to submit data');
        }
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Successfully submitted'),
              actions: [
                TextButton(
                   onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OnboardingView()),
                      );
                    },
                  child: Text('Return to Home'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Registry Form'),
      ),
      body: Container(
        color: Colors.lightGreen[50],
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      fullName = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                InkWell(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        dob = selectedDate;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          dob != null ? '${dob!.day}/${dob!.month}/${dob!.year}' : 'Select Date',
                        ),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: selectedSubject,
                  onChanged: (value) {
                    setState(() {
                      selectedSubject = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a subject';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Subject Area'),
                  items: subjects.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      locationName = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Text('Marketing Updates'),
                    SizedBox(width: 8.0),
                    Switch(
                      value: marketingUpdates,
                      onChanged: (value) {
                        setState(() {
                          marketingUpdates = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Text('Correspondence in Welsh'),
                    SizedBox(width: 8.0),
                    Switch(
                      value: correspondenceInWelsh,
                      onChanged: (value) {
                        setState(() {
                          correspondenceInWelsh = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
