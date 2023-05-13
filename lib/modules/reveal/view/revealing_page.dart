import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:steganosaurus/global/common/column_spacer.dart';
import 'package:steganosaurus/global/config.dart';
import 'package:steganosaurus/global/models/reveal_envelope.dart';
import 'package:steganosaurus/global/utils/styles.dart';
import 'package:steganosaurus/modules/reveal/controller/revealing_controller.dart';
import 'package:steganosaurus/modules/reveal/view/revealing_result.dart';

import '../../../global/common/center_wrapper.dart';

class RevealingPage extends StatefulWidget {
  const RevealingPage({super.key});

  @override
  State<StatefulWidget> createState() => _RevealingPageState();
}

class _RevealingPageState extends State<RevealingPage> {
  final RevealEnvelope _envelope = mainPageStatesHolder.revealEnvelope;
  final _controller = RevealingController();

  @override
  void initState() {
    super.initState();
    _controller.revealFromImage(_envelope).then(
          (result) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RevealingResult(result)),
          ),
        );
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
            'msg.revealing',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: Styles.importantTextSize,
            ),
          ).tr(),
          const ColumnSpacer(Styles.smallGap)
        ]),
      ),
    );
  }
}
