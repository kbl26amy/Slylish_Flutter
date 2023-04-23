// import 'package:flutter/material.dart';
// import 'tappay_android_way.dart';
// import 'tappay_flutter_way.dart';

// class TappayPage extends StatefulWidget {
//   const TappayPage({super.key});

//   @override
//   TappayPageState createState() => TappayPageState();
// }

// class TappayPageState extends State<TappayPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: Center(
//           child: Column(
//         children: <Widget>[
//           TextButton(
//             child: const Text("Native way"),
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                 return TappayAndroidScreen();
//               }));
//             },
//           ),
//           TextButton(
//             child: Text("Flutter way"),
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                 return TappayFlutterScreen();
//               }));
//             },
//           )
//         ],
//       )),
//     );
//   }
// }
