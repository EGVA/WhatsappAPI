import 'package:WppAPI/controllers/home_controller.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeTextFieldInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              HomeController.instance.cellphone = value;
              HomeController.instance.callNotifyListeners();
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Número'),
          ),
          SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              HomeController.instance.message = value;
              HomeController.instance.callNotifyListeners();
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Mensagem'),
          ),
        ],
      ),
    );
  }
}

class HomeCompleteInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RaisedButton(
                child: Icon(Icons.copy),
                onPressed: () {
                  HomeController.copyURL();
                  HomeController.instance.addNewMessage(
                      HomeController.instance.message,
                      HomeController.instance.cellphone);
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                child: Icon(Icons.open_in_browser),
                onPressed: () {
                  HomeController.openURL();
                  HomeController.instance.addNewMessage(
                      HomeController.instance.message,
                      HomeController.instance.cellphone);
                },
              ),
            ),
          ],
        )
      ],
    ));
  }
}
