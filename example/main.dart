import 'package:abstract_models/abstract/abstract_models.dart';
import 'package:abstract_models/abstract/app/model/app_model.dart';
import 'package:abstract_models/feature/app/app_service.dart';
import 'package:abstract_models/abstract_models.dart';
import 'package:widget_console/widget/console_controller.dart';
import 'package:widget_console/widget/console_widget.dart';
import 'package:widget_console/widget/flutter_console_widget/flutter_console.dart';
import 'package:widget_console/widget/flutter_console_widget/flutter_console_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppService appService = AppService(AppModel());
  await appService.start();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'abstract_models',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  void echoLoop() {
    controller.scan().then((value) {
      controller.print(message: value, endline: true);
      controller.focusNode.requestFocus();
      echoLoop();
    });
  }

  final FlutterConsoleController controller = FlutterConsoleController();

  @override
  Widget build(BuildContext context) {
    echoLoop();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: FlutterConsole(controller: controller, height: size.height, width: size.width,)
    );
  }

  get c =>ConsoleWidget(controller: ConsoleWidgetController(commands: [
  ConsoleCommand('hello', const Text('hello')),
  ConsoleCommand('bull', const Text('bull')),
  ConsoleCommand('beki', const Text('beki'))]));



}