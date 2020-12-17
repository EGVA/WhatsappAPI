import 'package:WppAPI/controllers/home_controller.dart';
import 'package:WppAPI/widgets/home_historic_widget.dart';
import 'package:flutter/material.dart';
// Widgets
import '../widgets/home_inputs_widget.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController;

  void initState() {
    super.initState();
    homeController = HomeController.instantiate();
    homeController.loadMessages();
    homeController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              HomeTextFieldInputs(),
              SizedBox(height: 10),
              HomeCompleteInputs(),
              SizedBox(height: 10),
              Container(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Center(
                            child: Text(HomeController.instance.generateURL())),
                      ],
                    )),
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[200]),
              ),
              SizedBox(height: 10),
              HistoricCard(),
            ],
          ),
        ),
      ),
    );
  }
}
