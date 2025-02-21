import 'package:flutter/material.dart';

mixin CheckboxHelperUtils{
  Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
        WidgetState.selected
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0xFF371382);
      }
      return Colors.transparent;
    }
}