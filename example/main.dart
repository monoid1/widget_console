import 'package:abstract_models/abstract/app/model/app_model.dart';
import 'package:abstract_models/feature/app/app_service.dart';
import 'package:abstract_models/abstract_models.dart';
import 'package:widget_console/model/default_models.dart';
import 'package:widget_console/widget/console_widget_page.dart';

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
      home: ConsoleWidgetPage(commands: c,),
    );
  }
}


