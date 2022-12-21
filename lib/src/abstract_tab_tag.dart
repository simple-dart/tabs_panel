import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

abstract class AbstractTabTag extends PanelComponent with MixinActive {
  late ComponentFactory tabContentFactory;
  Component? _tabContent;

  String get caption;

  set caption(String newVal);

  Component get tabContent {
    _tabContent ??= tabContentFactory();
    return _tabContent!;
  }

  AbstractTabTag(String className) : super(className);
}
