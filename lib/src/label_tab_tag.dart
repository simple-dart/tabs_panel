import 'package:simple_dart_label/simple_dart_label.dart';
import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

import '../simple_dart_tabs_panel.dart';

class LabelTabTag extends AbstractTabTag {
  Label label = Label();

  LabelTabTag(Component tabContent) : super('TabTag') {
    add(label);
    tabContentFactory = () => tabContent;
  }

  @override
  String get caption => label.caption;

  @override
  set caption(String newVal) {
    label.caption = newVal;
  }
}
