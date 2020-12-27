import 'package:WppAPI/controllers/home_controller.dart';
import 'package:WppAPI/widgets/home_historic_widget.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
// Widgets
import '../app_localizations.dart';
import '../widgets/home_inputs_widget.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController;
  AdmobBannerSize bannerSize;

  void initState() {
    super.initState();
    Admob.requestTrackingAuthorization();
    bannerSize = AdmobBannerSize.BANNER;

    homeController = HomeController.instantiate();
    homeController.loadMessages();
    homeController.getShowHistoryPreview();
    homeController.addListener(() {
      setState(() {});
    });
  }

  void handleAdmobEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('Loaded admob $adType');

        break;
      case AdmobAdEvent.opened:
        print('Opened admob $adType');
        break;
      case AdmobAdEvent.closed:
        print('Closed admob $adType');
        break;
      case AdmobAdEvent.failedToLoad:
        print('Failed to load admob $adType');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    if (homeController.status == Status.loading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else
      return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
            child: ListView(
          children: [
            SwitchListTile(
                title: Text(
                    AppLocalizations.of(context).translate('MessagePreview')),
                onChanged: (value) {
                  setState(() {
                    homeController.saveShowPreview(value);
                  });
                },
                value: homeController.showPreview),
            SwitchListTile(
                title: Text(
                    AppLocalizations.of(context).translate('MessageHistory')),
                onChanged: (value) {
                  setState(() {
                    homeController.saveShowHistory(value);
                  });
                },
                value: homeController.showHistory),
          ],
        )),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                HomeTextFieldInputs(),
                SizedBox(height: 10),
                HomeCompleteInputs(),
                homeController.showPreview ? SizedBox(height: 10) : Center(),
                homeController.showPreview ? MessasgePreview() : Center(),
                homeController.showHistory ? SizedBox(height: 10) : Center(),
                homeController.showHistory ? HistoricCard() : Center(),
                AdmobBanner(
                  //ca-app-pub-3940256099942544/6300978111
                  adUnitId: 'ca-app-pub-3660983415462718/1596865548',
                  listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                    handleAdmobEvent(event, args, 'Banner');
                  },
                  adSize: bannerSize,
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class MessasgePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Center(child: Text(HomeController.instance.generateURL())),
            ],
          )),
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.green[300]),
    );
  }
}
