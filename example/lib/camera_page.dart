import 'package:flutter/material.dart';
import 'package:flutter_mrz_scanner/flutter_mrz_scanner.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool isParsed = false;
  late MRZController controller;

  @override
  void initState() {
    super.initState();
    controller = MRZController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: MRZScanner(
        controller: controller,
        withOverlay: true,
        onError: print,
        onParsed: (result) async {
          if (isParsed) {
            return;
          }
          isParsed = true;

          await showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Document type: ${result.documentType}'),
                  Text('Country: ${result.countryCode}'),
                  Text('Surnames: ${result.surnames}'),
                  Text('Given names: ${result.givenNames}'),
                  Text('Document number: ${result.documentNumber}'),
                  Text('Nationality code: ${result.nationalityCountryCode}'),
                  Text('Birthdate: ${result.birthDate}'),
                  Text('Sex: ${result.sex}'),
                  Text('Expriy date: ${result.expiryDate}'),
                  Text('Personal number: ${result.personalNumber}'),
                  Text('Personal number 2: ${result.personalNumber2}'),
                  ElevatedButton(
                    child: const Text('ok'),
                    onPressed: () {
                      isParsed = false;
                      return Navigator.pop(context, true);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
