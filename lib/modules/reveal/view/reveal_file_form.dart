import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steganosaurus/global/models/reveal_envelope.dart';
import 'package:steganosaurus/modules/reveal/view/revealing_page.dart';

import '../../../global/common/confirm_button.dart';
import '../../../global/common/column_spacer.dart';
import '../../../global/common/scrollable_wrapper.dart';
import '../../../global/common/select_button.dart';
import '../../../global/common/key_field.dart';
import '../../../global/config.dart';
import '../../../global/controllers/file_pickers.dart';
import '../../../global/utils/styles.dart';
import '../../../global/utils/supported_locales.dart';
import '../../../global/widgets/error_message.dart';
import '../../../global/widgets/image_preview.dart';

class RevealFileForm extends StatefulWidget {
  /// Form used for revealing hidden files from images.
  const RevealFileForm({super.key});

  @override
  State<RevealFileForm> createState() => _RevealFileFormState();
}

class _RevealFileFormState extends State<RevealFileForm> {
  // Field is used for re-rendering if language is changed
  // ignore: unused_field
  Locale _currentLocale = SupportedLocales.english;

  final RevealEnvelope _envelope = mainPageStatesHolder.revealEnvelope;
  final TextEditingController _keyController = TextEditingController();
  bool _validating = false;
  String? _errorMessage;

  @override
  void initState() {
    _keyController.text = _envelope.decryptKey ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _currentLocale = context.locale;
    return ScrollableWrapper([
      ImagePreview(_envelope.imgPath),
      const ColumnSpacer(Styles.smallGap),
      SelectButton(
        onPressed: () {
          pickPNGPath(_envelope.imgPath).then((path) => setState(() => {
                _envelope.imgPath = path,
                _errorMessage = null,
              }));
        },
        icon: const Icon(Icons.add_photo_alternate_rounded),
        label: _envelope.imgPath != null
            ? const Text('btn.changeImg').tr()
            : const Text('btn.selectImg').tr(),
      ),
      const ColumnSpacer(Styles.bigGap),
      KeyField(
        icon: const Icon(Icons.key_rounded),
        onChange: (value) {
          setState(() {
            _envelope.decryptKey = value;
          });
        },
        label: tr('lbl.decryptKey'),
        hintText: tr('lbl.decryptKeyHint'),
        controller: _keyController,
      ),
      const ColumnSpacer(Styles.bigGap),
      ConfirmButton(
        label: tr('btn.revealFile'),
        onPressed: _envelope.isImgSelected() && !_validating
            ? () {
                setState(() {
                  _validating = true;
                  _envelope.validate().then((result) => {
                        if (result.isValid)
                          {
                            _errorMessage = null,
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RevealingPage()),
                            ),
                          }
                        else
                          {
                            _errorMessage = result.message,
                          }
                      });
                  _validating = false;
                });
              }
            : null,
      ),
      const ColumnSpacer(Styles.smallGap),
      if (_errorMessage != null) ...[ErrorMessage(_errorMessage!)]
    ]);
  }
}
