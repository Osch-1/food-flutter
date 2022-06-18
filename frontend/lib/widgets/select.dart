import 'package:flutter/material.dart';

class Select<TOption> extends StatelessWidget {
  const Select({
    @required this.options,
    @required this.value,
    @required this.valueDescription,
    @required this.onChanged,
    this.dialogTitle,
    this.textStyle,
  });

  final String dialogTitle;
  final Map<String, TOption> options;
  final TOption value;
  final String valueDescription;
  final void Function(TOption) onChanged;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) => FlatButton(
        onPressed: options == null || onChanged == null
            ? null
            : () async {
                onChanged(
                  await showDialog<TOption>(
                        context: context,
                        builder: (BuildContext context) => SimpleDialog(
                          title: dialogTitle == null ? null : Text(dialogTitle),
                          children: <Widget>[
                            for (final MapEntry<String, TOption> option
                                in options.entries)
                              SimpleDialogOption(
                                onPressed: () =>
                                    Navigator.pop(context, option.value),
                                child: Text(option.key),
                              ),
                          ],
                        ),
                      ) ??
                      value,
                );
              },
        child: Text(valueDescription, style: textStyle),
      );
}
