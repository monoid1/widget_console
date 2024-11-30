import 'package:abstract_models/abstract/widget/a_page_widget.dart';
import 'package:widget_console/widget/console_controller.dart';
import 'package:widget_console/widget/console_widget.dart';

class ConsoleWidgetPage extends StatelessWidget {
  const ConsoleWidgetPage({super.key,this.commands=const[]});


  final List<ConsoleCommand> commands;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConsoleWidget(controller: ConsoleWidgetController(commands: commands)),
    );
  }
}
