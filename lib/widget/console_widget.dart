import 'package:abstract_models/abstract/widget/a_widget.dart';
import 'package:flutter/services.dart';

import 'console_controller.dart';

class ConsoleWidget extends AWidget<ConsoleWidgetController> {
  ConsoleWidget({super.key, required ConsoleWidgetController controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: LayoutBuilder(
        builder: (c, l) => Obx(
          () => Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: ListView(
                    children: [...controller.widgets],
                  ),
                ),
              ),
              Container(
                color: Colors.grey,
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.chevron_right),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: OverlayPortal(
                            child: TextField(
                                controller: controller.textEditingController,
                                focusNode: controller.focusNode,
                                onChanged: controller.onChanged,
                                onSubmitted: controller.onSubmitted,
                                enableInteractiveSelection: false,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white24,
                                )),
                            controller: controller.portal,
                            overlayChildBuilder: (c) => Positioned(
                                  left: 30,
                                  bottom: 60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    width: 300,
                                    height: 100,
                                    child: ListView(
                                      reverse: true,
                                      children: [...controller.suggestions],
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ],
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
  ConsoleCommand({
    required this.name,
    this.widget=const SizedBox(),
    this.call
  });

  String name;

  Widget widget;

  Function? call;
}
