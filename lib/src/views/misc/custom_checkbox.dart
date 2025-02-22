import 'package:flutter/material.dart';
import 'package:take_a_break/src/constants/asset_constants.dart';

class CustomCheckbox extends StatefulWidget {
  double? size;
  double? iconSize;
  Function(bool) onChanged;
  Color? backgroundColor;
  Color? checkColor;
  Color? borderColor;
  IconData? icon;
  bool value;
  bool isCircle;

  CustomCheckbox(
      {Key? key,
      this.size,
      this.iconSize,
      required this.onChanged,
      this.backgroundColor,
      this.checkColor,
      this.icon,
      this.borderColor,
      required this.value,
      required this.isCircle})
      : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value;
  }

  @override
  void didUpdateWidget(covariant CustomCheckbox oldWidget) {
    if(oldWidget.value!=widget.value){
      setState(() {
        isChecked=widget.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChanged(isChecked);
        });
      },
      child: AnimatedContainer(
          height: widget.size ?? 24,
          width: widget.size ?? 24,
          padding: EdgeInsets.zero,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.isCircle ? 1000 : 4),
              color: isChecked
                  ? widget.backgroundColor ?? Colors.blue
                  : Colors.transparent,
              // border: Border.all(color: widget.borderColor ?? Colors.black)
              border: Border.all(
                  color: widget.borderColor ?? Color(0xFFD8DAE5), width: 2)),
          child: isChecked
              ?
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:MainAxisAlignment.center ,
                children: [
                  Image.asset(
                      AssetConstants.tick,
                      filterQuality: FilterQuality.high,
                      height: 10,
                      width: 10,
                    ),
                ],
              )
              : null),
    );
  }
}
