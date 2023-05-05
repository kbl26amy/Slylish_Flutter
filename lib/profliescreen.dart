import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _localRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  bool _inCalling = false;
  bool _isTorchOn = false;
  ImageProvider _photo = NetworkImage(
      'https://cdn1.cybassets.com/media/W1siZiIsIjE3NzMwL3Byb2R1Y3RzLzMzMjgzODMzLzE2MTY3MzY2NDhfZGY1MmMxYmI3ZTI3MjVjNjU4Y2QuanBlZyJdLFsicCIsInRodW1iIiwiNjAweDYwMCJdXQ.jpeg?sha=35548b71283885ae');

  List<MediaDeviceInfo>? _mediaDevicesList;

  @override
  void initState() {
    super.initState();
    initRenderers();
    navigator.mediaDevices.ondevicechange = (event) async {
      print('++++++ ondevicechange ++++++');
      _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
    };
  }

  void initRenderers() async {
    await _localRenderer.initialize();
  }

  @override
  void deactivate() {
    super.deactivate();
    if (_inCalling) {
      _hangUp();
    }
    _localRenderer.dispose();
    navigator.mediaDevices.ondevicechange = null;
  }

  void _hangUp() async {
    try {
      if (kIsWeb) {
        _localStream?.getTracks().forEach((track) => track.stop());
      }
      await _localStream?.dispose();
      _localRenderer.srcObject = null;
      setState(() {
        _inCalling = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _makeCall() async {
    final mediaConstraints = <String, dynamic>{
      'audio': false,
      'video': {
        'mandatory': {
          'minWidth':
              '640', // Provide your own width, height and frame rate here
          'minHeight': '480',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };

    try {
      var stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
      _localStream = stream;
      _localRenderer.srcObject = _localStream;
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;

    setState(() {
      _inCalling = true;
    });
  }

  void _captureFrame() async {
    if (_localStream == null) throw Exception('Stream is not initialized');

    final videoTrack = _localStream!
        .getVideoTracks()
        .firstWhere((track) => track.kind == 'video');
    final frame = await videoTrack.captureFrame();

    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content:
                  Image.memory(frame.asUint8List(), height: 720, width: 1280),
            ));
    _hangUp();
    // setState(() {
    //   _photo = Image.memory(frame.asUint8List(), height: 720, width: 1280)
    //       as ImageProvider;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          height: 20,
        ),
      ),
      body: Center(
        child: CircleAvatar(
          radius: 220,
          backgroundColor: Colors.white,
          child: CircleAvatar(
              radius: 210,
              backgroundImage: _photo,
              backgroundColor: Colors.green,
              child: RTCVideoView(_localRenderer, mirror: true)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inCalling ? _captureFrame : _makeCall,
        tooltip: _inCalling ? 'take a pic' : 'Take PIC',
        child: Icon(_inCalling ? Icons.camera : Icons.camera_alt_rounded,
            color: Colors.white),
      ),
    );
  }
}
