import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Crosschannel extends StatefulWidget {
  const Crosschannel({super.key});
  @override
  State<StatefulWidget> createState() {
    return CrosschannelState();
  }
}

class CrosschannelState extends State<Crosschannel> {
  
  static const platform = MethodChannel('samples.flutter.io/systemVersion');
  // Get battery level.
  String _systemVersion = 'Unknown system version.';

  Future<void> _getSystemVersion() async {
    String systemVersion;
    try {
      final String result = await platform.invokeMethod('systemVersion');
      systemVersion = 'iOS系统 $result.';
    } on PlatformException catch (e) {
      systemVersion = "Failed to get system version: '${e.message}'.";
    }
    setState(() {
      _systemVersion = systemVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getSystemVersion();
    
    return Center(
      child: Column(
        children: <Widget>[
          Text(_systemVersion),
        ],
      ),
    );
  }
}
