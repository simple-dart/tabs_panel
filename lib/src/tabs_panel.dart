import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

import '../simple_dart_tabs_panel.dart';

class TabsPanel extends PanelComponent
    with ValueChangeEventSource<AbstractTabTag>
    implements StateComponent<AbstractTabTag> {
  Panel tagsPanel = Panel()
    ..addCssClass('TabTagsPanel')
    ..spacing = '1px'
    ..wrap = true;
  List<AbstractTabTag> tags = <AbstractTabTag>[];
  AbstractTabTag? _currentTag;
  Panel contentPanel = Panel()
    ..addCssClass('TabContentPanel')
    ..fullSize()
    ..vertical = true
    ..fillContent = true;

  TabsPanel() : super('TabsPanel') {
    vertical = true;
    add(tagsPanel);
  }

  AbstractTabTag addTabTag(AbstractTabTag newTabTag) {
    tagsPanel.add(newTabTag);
    tags.add(newTabTag);
    newTabTag.element.onClick.listen((event) {
      currentTag = newTabTag;
    });
    return newTabTag;
  }

  AbstractTabTag get currentTag => _currentTag!;

  set currentTag(AbstractTabTag newTag) {
    if (_currentTag != newTag) {
      final oldTag = _currentTag;
      if (_currentTag != null) {
        _currentTag!.active = false;
        removeComponent(_currentTag!.tabContent);
      }
      _currentTag = newTag;
      _currentTag!.active = true;
      add(_currentTag!.tabContent);
      if (oldTag != null) {
        fireValueChange(oldTag, _currentTag!);
      } else {
        fireValueChange(newTag, newTag);
      }
    }
  }

  @override
  void clear() {
    tags.clear();
    tagsPanel.clear();
  }

  @override
  String get state {
    var res = currentTag.tabContent.varName;
    if (res.isEmpty) {
      res = currentTag.caption;
    }
    return res;
  }

  @override
  set state(String newValue) {
    if (newValue.isEmpty) {
      if (tags.isNotEmpty) {
        currentTag = tags.first;
      }
      return;
    }
    final tabTag = tags.firstWhere((tag) {
      if (tag.tabContent.varName.isEmpty) {
        return tag.caption == newValue;
      } else {
        return tag.tabContent.varName == newValue;
      }
    }, orElse: () => tags.first);
    currentTag = tabTag;
  }
}
