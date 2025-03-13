import 'package:flutter/material.dart';

import '../utils /responsiveness.dart';

class Space extends StatelessWidget {
  final double? width;
  final double? height;

  const Space({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final helper = ResponsiveHelper.of(context);

    return SizedBox(
      width: width != null ? helper.scaleWidth(width!) : null,
      height: height != null ? helper.scaleHeight(height!) : null,
    );
  }
}
