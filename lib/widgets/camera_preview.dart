import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:typed_data';

class VideoRecorder extends StatefulWidget {
  @override
  _VideoRecorderState createState() => _VideoRecorderState();
}

class _VideoRecorderState extends State<VideoRecorder>
    with WidgetsBindingObserver {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  XFile? videoFile;
  List<CameraDescription> _cameras = [];
  bool _isRecording = false;

  late PoseDetector _poseDetector;
  List<Pose> _poses = [];
  bool _isProcessingImage = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializePoseDetector();
  }

  Future<void> _initializePoseDetector() async {
    try {
      _poseDetector = PoseDetector(
        options: PoseDetectorOptions(model: PoseDetectionModel.accurate),
      );
      log("Pose Detector Initialized");
    } catch (e) {
      log("Error initializing Pose Detector: $e");
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      final firstCamera = _cameras.first;
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;

      if (mounted) {
        setState(() {});
      }

      _controller!.startImageStream((image) {
        if (!_isProcessingImage) {
          _processCameraImage(image);
        }
      });
    } catch (e) {
      log("Error initializing camera: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Camera initialization failed: $e")),
      );
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    _isProcessingImage = true;
    try {
      final inputImage = _convertCameraImageToInputImage(image);
      final poses = await _poseDetector.processImage(inputImage);
      if (mounted) {
        setState(() {
          _poses = poses;
        });
      }
    } catch (e) {
      log("MediaPipe processing error: $e");
    }
    _isProcessingImage = false;
  }

  InputImage _convertCameraImageToInputImage(CameraImage image) {
    final bytes =
        image.planes.map((plane) => plane.bytes).expand((x) => x).toList();
    final metadata = InputImageData(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      imageRotation: InputImageRotation.rotation0deg,
      inputImageFormat: InputImageFormat.nv21,
      planeData: image.planes.map((plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      }).toList(),
    );

    return InputImage.fromBytes(
        bytes: Uint8List.fromList(bytes), inputImageData: metadata);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Recorder')),
      body: Stack(
        children: [
          _initializeControllerFuture == null
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
          CustomPaint(
            painter: PosePainter(_poses),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            if (_controller == null) return;
            if (_isRecording) {
              final file = await _controller!.stopVideoRecording();
              setState(() {
                videoFile = file;
                _isRecording = false;
              });
              _saveVideoLocally(file);
            } else {
              await _controller!.startVideoRecording();
              setState(() {
                _isRecording = true;
              });
            }
          } catch (e) {
            log("Recording error: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Recording error: $e")),
            );
          }
        },
        child: Icon(_isRecording ? Icons.stop : Icons.videocam),
      ),
    );
  }

  Future<void> _saveVideoLocally(XFile file) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.mp4";
      final filePath = '${directory.path}/$fileName';
      await File(file.path).copy(filePath);
      log("Video saved to: $filePath");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Video saved to local storage")),
      );
    } catch (e) {
      log("Error saving video: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save video")),
      );
    }
  }
}

class PosePainter extends CustomPainter {
  final List<Pose> poses;

  PosePainter(this.poses);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (final pose in poses) {
      for (final landmark in pose.landmarks.values) {
        if (landmark.likelihood > 0.5) {
          final x = landmark.x * size.width;
          final y = landmark.y * size.height;
          canvas.drawCircle(Offset(x, y), 5, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.poses != poses;
  }
}
