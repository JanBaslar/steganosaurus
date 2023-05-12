import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steganosaurus/global/common/confirm_button.dart';
import 'package:steganosaurus/global/common/column_spacer.dart';
import 'package:steganosaurus/global/common/scrollable_wrapper.dart';
import 'package:steganosaurus/global/common/select_button.dart';
import 'package:steganosaurus/global/common/steg_field.dart';
import 'package:steganosaurus/global/config.dart';
import 'package:steganosaurus/global/models/hide_envelope.dart';
import 'package:steganosaurus/global/widgets/error_message.dart';
import 'package:steganosaurus/global/widgets/file_preview.dart';
import 'package:steganosaurus/modules/hide/view/hiding_page.dart';
import '../../../global/controllers/file_pickers.dart';
import '../../../global/utils/styles.dart';
import '../../../global/utils/supported_locales.dart';
import '../../../global/widgets/image_preview.dart';

class HideFileForm extends StatefulWidget {
  /// Form used for hiding files into images.
  const HideFileForm({super.key});

  @override
  State<HideFileForm> createState() => _HideFileFormState();
}

class _HideFileFormState extends State<HideFileForm> {
  // Field is used for re-rendering if language is changed
  // ignore: unused_field
  Locale _currentLocale = SupportedLocales.english;

  final HideEnvelope _envelope = mainPageStatesHolder.hideEnvelope;
  final TextEditingController _keyController = TextEditingController();
  bool _validating = false;
  String? _errorMessage;

  @override
  void initState() {
    _keyController.text = _envelope.encryptKey ?? '';
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
          pickImgPath(_envelope.imgPath).then((path) => setState(() => {
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
      FilePreview(_envelope.filePath),
      const ColumnSpacer(Styles.smallGap),
      SelectButton(
        onPressed: () {
          pickFilePath(_envelope.filePath).then((path) => setState(() => {
                _envelope.filePath = path,
                _errorMessage = null,
              }));
        },
        icon: const Icon(Icons.note_add),
        label: _envelope.filePath != null
            ? const Text('btn.changeFile').tr()
            : const Text('btn.selectFile').tr(),
      ),
      const ColumnSpacer(Styles.bigGap),
      StegField(
        icon: const Icon(Icons.key_rounded),
        onChange: (value) {
          setState(() {
            _envelope.encryptKey = value;
          });
        },
        label: tr('lbl.encryptKey'),
        hintText: tr('lbl.encryptKeyHint'),
        controller: _keyController,
      ),
      const ColumnSpacer(Styles.bigGap),
      ConfirmButton(
        label: tr('btn.hideFile'),
        onPressed: _envelope.areFilesSelected() && !_validating
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
                                  builder: (context) => const HidingPage()),
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
