import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/messages_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {
  String message = "";
  String cellphone = "";

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
    Clipboard.setData(
        new ClipboardData(text: 'https://api.whatsapp.com/send?phone=$_cellphone&text=$_message'));
  }
  static customOpenURL(String _message, String _cellphone) async {
    String generatedURL = 'https://api.whatsapp.com/send?phone=$_cellphone&text=$_message';

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
    savedMessages.add(SavedMessage(message: _message, cellphone: _cellphone));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('savedMessages', json.encode(savedMessages));
    notifyListeners();
  }
  loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedString = prefs.getString('savedMessages');
    if(savedString != null){
      List decoded = json.decode(savedString);
      decoded.forEach((e) => savedMessages.add(SavedMessage(cellphone: e['cellphone'], message: e['message'])));
      notifyListeners();
    }else
      return 'no data saved';
  }
}
