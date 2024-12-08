import 'package:abstract_models/abstract/widget/a_widget.dart';
import 'package:abstract_models/abstract_models.dart';
import 'package:widget_console/model/default_models.dart';
import 'package:widget_console/widget/console_widget_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();




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


