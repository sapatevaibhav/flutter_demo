// ignore_for_file: prefer__ructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  int a = 0;
  int b = 0;
  num c = 0;

  final displayOneController = TextEditingController();
  final displayTwoController = TextEditingController();
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    displayTwoController.text = b.toString();
    displayOneController.text = a.toString();
    displayOneController.clear();
    displayTwoController.clear();

    _listener = AppLifecycleListener(
      onDetach: _onDetach,
      onHide: _onHide,
      onInactive: _onInactive,
      onPause: _onPause,
      onRestart: _onRestart,
      onResume: _onResume,
      onShow: _onShow,
    );
  }

  void _onDetach() => log("Detached");
  void _onHide() => log("Hidden"); //
  void _onInactive() => log("Inactive"); //
  void _onRestart() => log("Restart"); //
  void _onResume() => log("Resume"); //
  void _onShow() => log("Show"); //
  void _onPause() => log("Paused"); //

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          //  Calculator display
          Display(
            hint: "Enter first number",
            controller: displayOneController,
            focused: true,
          ),
          SizedBox(
            height: 10,
          ),
          Display(
            hint: "Enter second number",
            controller: displayTwoController,
            focused: false,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            c.toString(),
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    c = num.tryParse(displayOneController.text)! +
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: Icon(CupertinoIcons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    c = num.tryParse(displayOneController.text)! -
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: Icon(CupertinoIcons.minus),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    c = num.tryParse(displayOneController.text)! *
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: Icon(CupertinoIcons.multiply),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    c = num.tryParse(displayOneController.text)! /
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: Icon(CupertinoIcons.divide),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              a = 0;
              b = 0;
              c = 0;
              displayOneController.clear();
              displayTwoController.clear();
            },
            label: Text("Clear"),
          )
        ],
      ),
    );
  }
}

class Display extends StatelessWidget {
  Display({
    super.key,
    this.hint = "Enter a number",
    required this.focused,
    required this.controller,
  });

  final String? hint;
  final bool focused;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      autofocus: focused,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
