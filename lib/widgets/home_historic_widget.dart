import 'package:WppAPI/app_localizations.dart';
import 'package:WppAPI/controllers/home_controller.dart';
import 'package:WppAPI/models/messages_model.dart';
import 'package:flutter/material.dart';

class HistoricCard extends StatelessWidget {
  savedMessageOptions(
      BuildContext context, String _message, String _cellphone) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  HomeController.customCopyURL(_message, _cellphone);
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context).translate('Copy')),
              ),
              TextButton(
                onPressed: () {
                  HomeController.customOpenURL(_message, _cellphone);
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context).translate('OpenInBrowser')),
              ),
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green[200]),
        child: Center(
            child: ListView.builder(
          itemCount: HomeController.instance.savedMessages.length,
          itemBuilder: (BuildContext ctxt, int index) {
            List<SavedMessage> reversedList = HomeController.instance.savedMessages.reversed.toList(); 
            return OutlinedButton(
              onPressed: () {
                savedMessageOptions(
                    context,
                    reversedList[index].message,
                    reversedList[index].cellphone);
              },
              child: ListTile(
                onTap: null,
                title:
                    Text(reversedList[index].message),
                subtitle: Text(
                    reversedList[index].cellphone),
              ),
            );
          },
        )),
      ),
    );
  }
}
