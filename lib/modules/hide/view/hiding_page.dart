import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:steganosaurus/global/common/column_spacer.dart';
import 'package:steganosaurus/global/config.dart';
import 'package:steganosaurus/global/models/hide_envelope.dart';
import 'package:steganosaurus/global/utils/styles.dart';
import 'package:steganosaurus/modules/hide/controller/hiding_controller.dart';

import '../../../global/common/center_wrapper.dart';

class HidingPage extends StatefulWidget {
  const HidingPage({super.key});

  @override
  State<StatefulWidget> createState() => _HidingPageState();
}

class _HidingPageState extends State<HidingPage> {
  final HideEnvelope _envelope = mainPageStatesHolder.hideEnvelope;
  final _controller = HidingController();

  @override
  void initState() {
    super.initState();
    _controller.hello();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: CenterWrapper([
          SpinKitWave(
            color: Theme.of(context).colorScheme.primary,
          ),
          const ColumnSpacer(Styles.smallGap),
          Text(
            'Loading files',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: Styles.importantTextSize,
            ),
          ),
          const ColumnSpacer(Styles.smallGap)
        ]),
      ),
    );
  }
}
