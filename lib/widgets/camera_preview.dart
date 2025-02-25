import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class VideoRecorder extends StatefulWidget {
  @override
  _VideoRecorderState createState() => _VideoRecorderState();
}

class _VideoRecorderState extends State<VideoRecorder> {
  CameraController? _controller; // Make _controller nullable
  Future<void>? _initializeControllerFuture; // Make nullable
  XFile? videoFile;

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
      _initializeControllerFuture =
          _controller!.initialize(); // Force unwrap here
      await _initializeControllerFuture;
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("Error initializing camera: $e");
      // Handle the error (e.g., show an error message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Camera initialization failed: $e")),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose(); // Use safe navigation
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Recorder')),
      body: _initializeControllerFuture == null
          ? Center(child: Text("Camera initializing..."))
          : FutureBuilder<void>(
              future: _initializeControllerFuture!, // Force unwrap here
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _controller != null
                      ? CameraPreview(_controller!) // Force unwrap here
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
              return; // Controller not initialized
            }
            if (_controller!.value.isRecordingVideo) {
              videoFile = await _controller!.stopVideoRecording();
              if (videoFile != null) {
                final directory = await getApplicationDocumentsDirectory();
                final filePath = '${directory.path}/${DateTime.now()}.mp4';
                final file = File(videoFile!.path);
                await file.copy(filePath);
                print("video saved to: $filePath");
              }
              setState(() {});
            } else {
              await _controller!.startVideoRecording();
              setState(() {});
            }
          } catch (e) {
            print(e);
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
