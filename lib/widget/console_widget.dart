import 'package:abstract_models/abstract/widget/a_widget.dart';

import 'console_controller.dart';

class WidgetConsole extends AWidget<WidgetConsoleController> {
  WidgetConsole(
      {this.margin,
     this.padding, super.key, required WidgetConsoleController controller});

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: LayoutBuilder(
        builder: (c, l) => Obx(
          () => Container(
            margin: margin,
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(

                        padding: padding??EdgeInsets.zero,

                      child: ListView(
                        shrinkWrap: true,
                        children: [...controller.widgets],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.chevron_right),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: OverlayPortal(
                              controller: controller.portal,
                              overlayChildBuilder: (c) => Positioned(
                                    left: 40,
                                    bottom: 70,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.focusNode.requestFocus();
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        width: 300,
                                        height: 100,
                                        child: ListView(
                                          reverse: true,
                                          children: [...controller.suggestions],
                                        ),
                                      ),
                                    ),
                                  ),
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
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConsoleCommand {
  ConsoleCommand(
      {required this.name, this.widget = const SizedBox(), this.call});

  String name;

  Widget widget;

  Function? call;
}
