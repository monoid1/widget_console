import 'package:abstract_models/abstract/widget/a_widget.dart';
import 'package:flutter/services.dart';

import 'console_controller.dart';

class ConsoleWidget extends AWidget<ConsoleWidgetController> {
  ConsoleWidget({super.key, required ConsoleWidgetController controller});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: double.infinity,
        child: LayoutBuilder(
          builder: (c,l) => Obx(
            ()=> Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 300,
                    width: 300,
                    child: ListView(
                      children: [...controller.widgets],
                    ),
                  ),
                ),
                if(controller.suggestions.isNotEmpty)
                Positioned(
                  bottom: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                    ),
                    width: 300,
                    height: 100,
                    child: ListView(
                      reverse: true,
                      children: [...controller.suggestions],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 100,
                    width: l.maxWidth,
                    padding: EdgeInsets.all(8),
                    child: TextField(
                        enableInteractiveSelection: false,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          prefix: Text('> '),
                        ),
                        controller: controller.textEditingController,
                        focusNode: controller.focusNode,
                        onChanged: controller.onChanged,
                        onSubmitted: controller.onSubmitted),
                  ),
                ),
              ],
            ),
          ),

            ),
      );
  }
}

class ConsoleCommand {
  ConsoleCommand(this.name, this.widget);

  String name;

  Widget widget;
}


