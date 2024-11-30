import 'package:abstract_models/abstract/widget/a_page_widget.dart';
import 'package:abstract_models/feature/user/widgets/login.dart';

import '../widget/console_widget.dart';

get c => [
  ConsoleCommand(
      name: 'login',
      widget: LoginPage(),
      call: () {
        print('login');
      }),
  ConsoleCommand(
      name: 'add',
      call: () {
        print('login');
      }),


  ConsoleCommand(
      name: 'hell',
      call: () {
        print('hell');
      }),
  ConsoleCommand(
    name: 'hello',
    widget: const Text('hello'),
  ),
  ConsoleCommand(name: 'bull', widget: const Text('bull')),
  ConsoleCommand(name: 'beki', widget: const Text('beki'))
];
