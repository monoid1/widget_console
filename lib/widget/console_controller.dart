import 'package:abstract_models/abstract/widget/a_controller.dart';
import 'package:abstract_models/abstract/widget/a_page_widget.dart';
import 'package:abstract_models/abstract/widget/a_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'console_widget.dart';

class WidgetConsoleController extends AController<WidgetConsoleController> {
  WidgetConsoleController({required this.commands});

  final List<ConsoleCommand> commands;

  final RxList<Widget> suggestions = RxList();

  ///keyboard listener focus node
  final FocusNode focusPortal = FocusNode();

  ///overlay portal with suggestions
  final OverlayPortalController portal = OverlayPortalController();

  final RxList<Widget> widgets = RxList();

  final TextEditingController textEditingController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  final Rx<String> selected = ''.obs;

  _characterTypeIn(String character) {
    //print(character);
    textEditingController.text += character;
  }

  ///current key timestamp
  Duration timeStamp = Duration();

  ///listen to input field key events
  @override
  void onInit() {
    focusNode.onKeyEvent = (f, k) {
      if (k.character != null) {
        _characterTypeIn(k.character ?? '');

        return KeyEventResult.handled;
      }
      if (k.character == null) {
        //print(k.physicalKey);

        ///Arrow up
        if (k.physicalKey.usbHidUsage == 0x00070052) {}

        ///Arrow down
        if (k.physicalKey.usbHidUsage == 0x00070051) {}

        ///Tab
        if (k is KeyDownEvent && k.logicalKey == LogicalKeyboardKey.tab) {
          var keyword = textEditingController.text;
          var c = commands
              .firstWhereOrNull((k) => k.name.contains(RegExp(keyword)));
          if (c != null) {
            print(c.name);
            textEditingController.text = c.name;
            WidgetsBinding.instance.addPostFrameCallback((d) {});
          }
        }

        ///Enter
        if (k is KeyDownEvent && k.logicalKey == LogicalKeyboardKey.enter) {
          focusNode.unfocus();
          focusNode.requestFocus();
          var keyword = textEditingController.text;
          var c = commands.firstWhereOrNull((k) => k.name == keyword);
          if (c != null) {
            addWidget(c.widget);
            if (c.call != null) {
              c.call!();
            }
          }
          textEditingController.text = '';
        }

        ///Backspace
        if (k.physicalKey.usbHidUsage == 0x0007002a && k is KeyDownEvent) {
          //print(timeStamp);
          var s = textEditingController.text;
          if (s.isNotEmpty) {
            var sub = s.substring(0, s.length - 1);
            textEditingController.text = sub;
          }
        }
      }

      return KeyEventResult.handled;
    };

    textEditingController.addListener(() {
      onChanged(textEditingController.text);
    });

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        //portal.hide();
      }
      if (focusNode.hasFocus && suggestions.isNotEmpty) {
        portal.show();
      }
    });
    super.onInit();
  }

  ///add widget to console view
  addWidget(Widget widget){
    widgets.add(Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget
      ],
    ));
  }



  _onEnterKey() {}

  onSubmitted(String text) {
    textEditingController.text = '';
    focusNode.requestFocus();

    for (var c in commands) {
      ///pick the first command from the list
      if (c.name == text) {
        widgets.add(c.widget);
      }
    }

    if (kDebugMode) {
      print(text);
    }
  }

  onChanged(String text) {
    portal.hide();
    this.suggestions.clear();
    List<Widget> suggestions = [];
    if (text.isEmpty) {
      return;
    }
    for (var i in commands) {
      if (i.name.contains(RegExp(text))) {
        //print(text);
        suggestions.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListTile(
                onTap: () {
                  print('tap');
                  setInput(i.name);
                },
                style: ListTileStyle.drawer,
                dense: true,
                title: Text(i.name),
              ),
            ),
          ],

        ));
      }
    }
    this.suggestions.addAll(suggestions);
    if (suggestions.isNotEmpty) {
      portal.show();
    }
  }






  suggestionOnTap() {}

  setInput(String text) {
    portal.hide();
    focusNode.requestFocus();
    textEditingController.text=text;
  }
}
