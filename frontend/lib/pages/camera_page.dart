import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage();

  @override
  Widget build(BuildContext context) =>
      // TODO(alexey-starovoitov): Mjpeg package should works after issue https://github.com/dart-lang/http/issues/270 being resolved.
      const Center(child: CircularProgressIndicator());
}
