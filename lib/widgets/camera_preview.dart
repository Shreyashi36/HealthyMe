import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VideoRecorder extends StatefulWidget {
  @override
  _VideoRecorderState createState() => _VideoRecorderState();
}

class _VideoRecorderState extends State<VideoRecorder>
    with WidgetsBindingObserver {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  XFile? videoFile;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _controller!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller != null) {
        _initializeCamera();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      log("Error initializing camera: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Camera initialization failed: $e")),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Recorder')),
      body: _initializeControllerFuture == null
          ? Center(child: Text("Camera initializing..."))
          : FutureBuilder<void>(
              future: _initializeControllerFuture!,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _controller != null
                      ? CameraPreview(_controller!)
                      : Center(child: Text("Camera preview error"));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            if (_controller == null) {
              return;
            }
            if (_controller!.value.isRecordingVideo) {
              videoFile = await _controller!.stopVideoRecording();
              if (videoFile != null) {
                try {
                  final directory = await getApplicationDocumentsDirectory();
                  final fileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  final filePath = '${directory.path}/$fileName.mp4';
                  final file = File(videoFile!.path);
                  await file.copy(filePath);
                  log("Video saved to: $filePath");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Video saved to local storage")),
                  );
                } catch (e) {
                  log("Error saving video to local storage: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to save video")),
                  );
                }
              }
              setState(() {});
            } else {
              await _controller!.startVideoRecording();
              setState(() {});
            }
          } catch (e) {
            log("Recording error: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Recording error: $e")),
            );
          }
        },
        child: Icon(
          _controller?.value.isRecordingVideo == true
              ? Icons.stop
              : Icons.videocam,
        ),
      ),
    );
  }
}
