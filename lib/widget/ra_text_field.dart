import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/constant.dart';
import 'custom_surffix_icon.dart';

class RATextField extends StatefulWidget {
  const RATextField(
      {Key? key,
      this.hint,
      this.label,
      this.prefix,
      this.surfix,
      this.controller,
      this.onChanged,
      this.keyBoardType,
      this.maxline,
      this.onTap,
      this.validators,
      this.isPassword = false,
      this.initialValue,
      this.textCapitalization,
      this.neverFocus = false,
      this.autoFocus = false,
      this.textInputAction,
      this.onsubmited,
      this.errorText,
      this.fontText})
      : super(key: key);
  final String? hint;
  final String? fontText;
  final String? initialValue;
  final String? label;
  final bool isPassword;
  final int? maxline;
  final dynamic prefix;
  final dynamic surfix;
  final bool neverFocus;
  final bool autoFocus;
  final String? errorText;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final TextInputType? keyBoardType;
  final Function()? onTap;
  final String? Function(String?)? validators;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String value)? onsubmited;

  @override
  State<RATextField> createState() => _RATextFieldState();
}

class _RATextFieldState extends State<RATextField> {
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
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      autofocus: widget.autoFocus,
      onFieldSubmitted: widget.onsubmited,
      style: TextStyle(
          fontFamily: widget.fontText != null ? 'bold' : 'regular',
          fontSize: sizeText,
          color: Colors.black),
      focusNode: _focusNodes[0],
      maxLines: widget.maxline ?? 1,
      onTap: widget.onTap,
      validator: widget.validators,
      obscureText: !visible,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        errorText: widget.errorText,
        errorStyle: TextStyle(color: Colors.red, fontFamily: "bold"),
        labelText: widget.label,
        labelStyle: TextStyle(
          fontFamily: 'bold',
          color:
              _focusNodes[0].hasFocus ? kPrimaryColorRouge : kPrimaryColorBleu,
        ),
        hintText: widget.hint,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColorBleu, width: 1.3)),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: 12,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ).copyWith(left: 20),
        prefixIcon: widget.prefix is String
            ? Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                width: 45,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.prefix,
                    style: TextStyle(
                      color: kPrimaryColorBleu,
                      fontFamily: "bold",
                    ),
                  ),
                ),
              )
            : widget.prefix is IconData
                ? Icon(widget.prefix)
                : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: changeVisible,
                icon: !visible
                    ? Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.grey,
                      )
                    : Icon(Icons.remove_red_eye_rounded,
                        color: kPrimaryColorRouge))
            : widget.surfix is String
                ? CustomSurffixIcon(
                    svgIcon: widget.surfix,
                  )
                : widget.surfix is IconData
                    ? Icon(
                        widget.surfix,
                        color: _focusNodes[0].hasFocus
                            ? kPrimaryColorRouge
                            : Colors.grey,
                      )
                    : widget.surfix is Widget
                        ? widget.surfix
                        : null,
      ),
      onChanged: widget.onChanged,
      controller: controller,
      keyboardType: widget.keyBoardType,
    );
  }
}
