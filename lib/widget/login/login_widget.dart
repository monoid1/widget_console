import 'package:abstract_models/abstract/backend/command.dart';
import 'package:abstract_models/abstract/widget/a_page_widget.dart';
import 'package:abstract_models/feature/user/model/user_model.dart';
import 'package:abstract_models/feature/user/widgets/password_input_widget.dart';
import 'package:abstract_models/widget/email_input_widet.dart';
import 'package:get/get.dart';


class LoginPage extends APageWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UserModel userModel = UserModel(
      userName: '',
      password: '',
      firstName: '',
      lastName: '',
      email: '',
      id: '');

  final RxString loginMessage = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: Obx(
            () => Center(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmailInputWidget(
                    onSaved: (s) => userModel.email = s ?? '',
                  ),
                  PasswordInputWidget(
                    onSaved: (s) => userModel.password = s ?? '',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool? a = _formKey.currentState?.validate();
                      print(a);
                      if (a == null || a == false) return;
                      _formKey.currentState?.save();
                      print(userModel.email);
                      print(userModel.password);

                      // loginMessage.value =
                      //     await LoginUserCommand(userModel).call();
                      LoginCommand(userModel).call();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(),
                    ),
                  ),
                  Divider(),
                  ElevatedButton(
                    onPressed: () async {
                      SignOutCommand(userModel).call();
                    },
                    child: Text(
                      'SignOut',
                      style: TextStyle(),
                    ),
                  ),
                  if (loginMessage.value.isNotEmpty)
                    Text(
                      loginMessage.value,
                      style:
                      TextStyle(color: Theme.of(context).colorScheme.error),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  String get widgetId => 'login_page';
}
