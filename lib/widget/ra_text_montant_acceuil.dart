import 'package:flutter/material.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../config/constant.dart';

import 'custom_surffix_icon.dart';
import 'feild_format.dart';

class RATextMontantField extends StatefulWidget {
  RATextMontantField({
    Key? key,
    this.hint,
    this.label,
    this.prefix,
    this.surfix,
    this.controller,
    this.onChanged,
    this.keyBoardType,
    this.maxline,
    this.onTap,
    this.isPassword = false,
    this.initialValue,
    this.textCapitalization,
    this.neverFocus = false,
    this.autoFocus = false,
    this.mask,
    this.colorText,
    this.colorBackground,
    this.testMontant,
    this.sizeHint,
    this.sizeText,
    this.sizeLabel,
    this.fontFamily,
    this.errorText,
    this.onsubmited,
    this.editable,
    this.focus,
  }) : super(key: key);
  final String? hint;
  final String? initialValue;
  final String? label;
  final bool isPassword;
  final int? maxline;
  final dynamic prefix;
  final dynamic surfix;
  final bool neverFocus;
  final bool autoFocus;
  final bool? testMontant;
  final bool? editable;
  final Color? colorText;
  final double? sizeHint;
  final double? sizeText;
  final double? sizeLabel;
  final String? fontFamily;

  final Color? colorBackground;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final Function(String value)? onsubmited;
  final TextInputType? keyBoardType;
  final Function()? onTap;
  final TextCapitalization? textCapitalization;
  final MaskTextInputFormatter? mask;
  final String? errorText;

  final FocusNode? focus;

  @override
  State<RATextMontantField> createState() => _RATextMontantFieldState();
}

class _RATextMontantFieldState extends State<RATextMontantField> {
  bool visible = true;
  var controller = TextEditingController();
  final focus = FocusNode();
  List<FocusNode> _focusNodes = [FocusNode(), FocusNode()];

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    // TODO: implement initState
    super.initState();
    if (widget.isPassword) {
      visible = false;
    }
    if (widget.controller != null) {
      controller = widget.controller!;
    }
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
    }
  }

  changeVisible() {
    visible = !visible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.neverFocus)
      focus.addListener(() {
        if (focus.hasFocus) {
          focus.unfocus();
        }
      });
    return TextFormField(
      readOnly: widget.editable!,
      onFieldSubmitted: widget.onsubmited,
      cursorColor: kPrimaryColorRouge,
      autofocus: widget.autoFocus,
      style: TextStyle(
          fontFamily: widget.fontFamily,
          fontSize: widget.sizeText,
          color: widget.colorText),
      focusNode: widget.focus,
      maxLines: widget.maxline ?? 1,
      onTap: widget.onTap,
      obscureText: !visible,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        errorText: widget.errorText,
        errorStyle: TextStyle(color: Colors.red, fontFamily: "bold"),
        labelText: widget.label,
        labelStyle: TextStyle(
          fontSize: widget.sizeLabel,
          fontFamily: "bold",
          color:
              _focusNodes[0].hasFocus ? kPrimaryColorRouge : kPrimaryColorBleu,
        ),
        hintText: widget.hint,
        filled: true,
        fillColor: widget.colorBackground,

        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColorBleu, width: 1.3)),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: widget.sizeHint,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ).copyWith(left: 20),
        prefixIcon: widget.prefix is String
            ? CustomSurffixIcon(
                svgIcon: widget.prefix,
              )
            : widget.prefix is IconData
                ? Icon(widget.prefix)
                : null,
        suffixIcon: widget.surfix,
      ),
      onChanged: widget.onChanged,
      controller: controller,
      keyboardType: widget.keyBoardType,
    );
  }
}
