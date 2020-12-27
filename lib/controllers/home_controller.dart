import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/messages_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { loading, ready }

class HomeController extends ChangeNotifier {
  bool showHistory = true, showPreview = true;
  String message = "";
  String cellphone = "";
  Status status = Status.loading;

  static HomeController instance;

  List<SavedMessage> savedMessages = new List<SavedMessage>();

  generateURL() {
    return 'https://api.whatsapp.com/send?phone=$cellphone&text=$message';
  }

  static copyURL() {
    Clipboard.setData(
        new ClipboardData(text: HomeController.instance.generateURL()));
  }

  static openURL() async {
    String generatedURL = HomeController.instance.generateURL();

    if (await canLaunch(generatedURL)) {
      await launch(generatedURL);
    } else {
      throw 'Could not launch $generatedURL';
    }
  }

  static customCopyURL(String _message, String _cellphone) {
    Clipboard.setData(new ClipboardData(
        text:
            'https://api.whatsapp.com/send?phone=$_cellphone&text=$_message'));
  }

  static customOpenURL(String _message, String _cellphone) async {
    String generatedURL =
        'https://api.whatsapp.com/send?phone=$_cellphone&text=$_message';

    if (await canLaunch(generatedURL)) {
      await launch(generatedURL);
    } else {
      throw 'Could not launch $generatedURL';
    }
  }

  static instantiate() {
    HomeController newInstance = HomeController();
    if (instance == null) {
      instance = newInstance;
      return newInstance;
    } else
      return null;
  }

  callNotifyListeners() {
    notifyListeners();
  }

  addNewMessage(String _message, String _cellphone) async {
    savedMessages.add(SavedMessage(cellphone: _cellphone, message: _message));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('savedMessages', json.encode(savedMessages));
    notifyListeners();
  }

  removeMessage(String _message, String _cellphone) async {
    savedMessages
        .removeWhere((e) => e.message == _message && e.cellphone == _cellphone);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('savedMessages', json.encode(savedMessages));
    notifyListeners();
  }

  loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedString = prefs.getString('savedMessages');
    if (savedString != null) {
      List decoded = json.decode(savedString);
      decoded.forEach((e) => savedMessages
          .add(SavedMessage(cellphone: e['cellphone'], message: e['message'])));
      status = Status.ready;
      notifyListeners();
    } else {
      status = Status.ready;
      notifyListeners();
      return 'no data saved';
    }
  }

  getShowHistoryPreview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showHistory = prefs.getBool('showHistory');
    showPreview = prefs.getBool('showPreview');
    notifyListeners();
  }

  saveShowHistory(newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showHistory = newValue;
    prefs.setBool('showHistory', newValue);
  }

  saveShowPreview(newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showPreview = newValue;
    prefs.setBool('showPreview', newValue);
  }
}
