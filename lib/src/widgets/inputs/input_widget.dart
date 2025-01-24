import 'package:flutter/material.dart';

import '../../../core/app/const.dart';

class InputWidget extends StatefulWidget {

  String text;
  String hintText;
  bool? obscureText;
  TextEditingController textEditingController;
  String? Function(String? value)? validator;


  InputWidget({
    super.key,
    required this.text,
    required this.hintText,
    required this.textEditingController,
    this.obscureText = false,
    this.validator
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {

  late bool obscureTextState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    obscureTextState = widget.obscureText!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // Title
          Expanded(
            child: Text(
              widget.text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          ),

          SizedBox(
            width: 180,
            child: Stack(
              children: [
                // Input
                TextFormField(
                  style: const TextStyle(color: AppColors.primary),
                  validator: widget.validator,
                  obscureText: obscureTextState,
                  controller: widget.textEditingController,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(color: AppColors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
                  ),
                ),

                // Icon Button
                if(widget.obscureText!)
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () {

                      setState(() {
                        obscureTextState = !obscureTextState;
                      });

                    },
                    icon: const Icon(Icons.remove_red_eye_outlined, color: AppColors.grey,)
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
