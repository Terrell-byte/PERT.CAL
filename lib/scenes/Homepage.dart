import 'package:flutter/material.dart';
import '../Constants.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

TextEditingController _title = TextEditingController();
TextEditingController _pess = TextEditingController();
TextEditingController _opti = TextEditingController();
TextEditingController _mlt = TextEditingController();

class _HomepageState extends State<Homepage> {
  int _currentStep = 0;
  String estimatetion = "Calculating...";
  double calculation = 0;

  void calculate() {
    setState(
      () {
        int pess = int.parse(_pess.text);
        int opti = int.parse(_opti.text);
        int mlt = int.parse(_mlt.text);
        calculation = ((opti + 4 * mlt + pess) / 6);
        estimatetion = getTimeStringFromDouble(calculation);
      },
    );
  }

  String getTimeStringFromDouble(double value) {
    if (value < 0) return 'Invalid Value';
    int flooredValue = value.floor();
    double decimalValue = value - flooredValue;
    String dayValue = getDayString(flooredValue);
    String hourValue = getHourString(flooredValue);
    String minuteString = getMinuteString(decimalValue);

    return '$dayValue d : $hourValue h : $minuteString m';
  }

  String getMinuteString(double decimalValue) {
    return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
  }

  String getHourString(int flooredValue) {
    return '${flooredValue % 24}'.padLeft(2, '0');
  }

  String getDayString(int flooredValue) {
    if (flooredValue > 23) {
      return '${(flooredValue / 24).floor()}'.padLeft(2, '0');
    } else {
      return '00'.padLeft(2, '0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: cIndianRed,
        title: Image.asset(
          'assets/images/title.png',
          height: 100,
          width: 100,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Scrollbar(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(primary: cIndianRed),
                  ),
                  child: Stepper(
                    steps: [
                      Step(
                        isActive: _currentStep >= 0,
                        title: const Text("Task title"),
                        content: TextField(
                          controller: _title,
                          decoration: const InputDecoration(
                              labelText: "Enter Title for Task"),
                        ),
                      ),
                      Step(
                        isActive: _currentStep >= 1,
                        title: const Text("Pessimistic Time"),
                        content: TextField(
                          controller: _pess,
                          decoration: const InputDecoration(
                              labelText: "Enter Time in Hours"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Step(
                        isActive: _currentStep >= 2,
                        title: const Text("Optimistic Time"),
                        content: TextField(
                          controller: _opti,
                          decoration: const InputDecoration(
                              labelText: "Enter Time in Hours"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Step(
                        isActive: _currentStep >= 3,
                        title: const Text("Most Likely Time"),
                        content: TextField(
                          controller: _mlt,
                          decoration: const InputDecoration(
                              labelText: "Enter Time in Hours"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                    onStepTapped: (int newIndex) {
                      setState(() {
                        _currentStep = newIndex;
                      });
                    },
                    currentStep: _currentStep,
                    onStepContinue: () {
                      final isLastStep = _currentStep == 3;

                      if (_currentStep != 3) {
                        setState(() {
                          _currentStep += 1;
                        });
                      }
                      if (isLastStep) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        calculate();
                      }
                    },
                    onStepCancel: () {
                      if (_currentStep != 0) {
                        setState(() {
                          _currentStep -= 1;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text("Estimation: " + estimatetion),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        backgroundColor: Colors.grey,
        mini: true,
        child: const Icon(Icons.question_mark),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(FAQtitle),
          content: Text(FAQtext),
        ),
      );
}
