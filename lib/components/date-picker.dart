import 'package:fbla_nlc_2024/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.onChange,});
  final void Function(int epoch) onChange;

  @override
  State<DatePicker> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime _selected = DateTime.now();

  void reset(){
    setState(() {
      _selected = DateTime.now();
    });
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoButton(
        onPressed: () => _showDialog(
          CupertinoDatePicker(
            initialDateTime: _selected,
            mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (e){
                setState(() {
                  _selected = e;
                });
                widget.onChange(e.millisecondsSinceEpoch);
              }
          )
        ),
        minSize: 0,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CupertinoTheme.of(context).barBackgroundColor.withOpacity(0.5),
              border: Border.all(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  width: 2
              )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatDateTime(_selected),
                  style: smallTitle.copyWith(color: Colors.white60),),
                SizedBox(width: 8,),
                Icon(Icons.edit_rounded, color: Colors.white60, size: 16,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}