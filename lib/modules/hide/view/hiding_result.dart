import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steganosaurus/global/common/column_spacer.dart';
import 'package:steganosaurus/global/common/result_icon.dart';
import 'package:steganosaurus/global/common/scrollable_wrapper.dart';
import 'package:steganosaurus/global/models/processing_result.dart';
import 'package:steganosaurus/global/utils/styles.dart';
import 'package:steganosaurus/global/widgets/error_message.dart';
import 'package:steganosaurus/global/widgets/image_preview.dart';

class HidingResult extends StatefulWidget {
  const HidingResult(this.result, {super.key});

  final ProcessingResult result;

  @override
  State<HidingResult> createState() => _HidingResultState();
}

class _HidingResultState extends State<HidingResult> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ),
        body: ScrollableWrapper([
          const ColumnSpacer(Styles.bigGap),
          ResultIcon(widget.result.success),
          const ColumnSpacer(Styles.smallGap),
          Text(
            widget.result.success ? 'rst.hidingSuccess' : 'rst.hidingFailed',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: widget.result.success
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.error,
                fontSize: Styles.importantTextSize),
          ).tr(),
          const ColumnSpacer(Styles.bigGap),
          widget.result.success
              ? ImagePreview(widget.result.filePath)
              : ErrorMessage(widget.result.message ?? ''),
          const ColumnSpacer(Styles.bigGap),
          if (widget.result.success) ...[
            Text('${tr('rst.imgSavedTo')} ${widget.result.filePath ?? ''}')
          ],
        ]),
      ),
    );
  }
}
