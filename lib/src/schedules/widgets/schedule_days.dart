import 'package:flutter/material.dart';

class ScheduleDays extends StatefulWidget {
  final int initialSelected;
  final Function selectDayFn;

  ScheduleDays(this.initialSelected, this.selectDayFn);

  @override
  _ScheduleDaysState createState() => _ScheduleDaysState();
}

class _ScheduleDaysState extends State<ScheduleDays> {
  final List<String> _weekdays = ['M', 'Tu', 'W', 'Th', 'F', 'Sa', 'Su'];
  int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Slider(
        value: _selectedIndex.toDouble(),
        min: 0.0,
        max: (_weekdays.length - 1).toDouble(),
        label: _weekdays[_selectedIndex],
        divisions: _weekdays.length - 1,
        onChanged: (selected) {
          setState(() {
            _selectedIndex = selected.toInt();
          });
          widget.selectDayFn(_selectedIndex);
        },
      ),
    );
  }
}
