import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/blocs/blocs.dart';
import 'package:app/generic.dart';
import 'package:app/navigation/navigation.dart';
import 'package:app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'login';

  const LoginPage({Key key}) : super(key: key);

  Widget _AuthFailure(authBloc, state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(state.message),
        TextButton(
          child: Text('Retry'),
          onPressed: () {
            authBloc.add(AppLoaded());
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state){
              if (state is AuthenticationAuthenticated) {
                Future.delayed(Duration(milliseconds: 100)).then((_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(PageRoutes.itemsList, (route) => false);
                });
              }
            },
            builder: (context, state) {
              if (state is AuthenticationNotAuthenticated) {
                return _AuthForm();
              } else if (state is AuthenticationFailure) {
                return _AuthFailure(authBloc, state);
              } else if (state is AuthenticationAuthenticated) {
                Future.delayed(Duration(milliseconds: 100)).then((_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(PageRoutes.itemsList, (route) => false);
                });
              }
              // return splash screen
              return Loader(child: Text('Authenticating...'));
            },
          )),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authService),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  Widget buildSubmitButton(BuildContext context, LoginState state) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      if (_key.currentState.validate()) {
        _loginBloc.add(LoginInWithEmailButtonPressed(email: _emailController.text, password: _passwordController.text));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return ElevatedButton(
      onPressed: state is LoginLoading ? () {} : _onLoginButtonPressed,
      child: Center(
        child: state is LoginLoading ? SizedBox(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)), height: 15, width: 15) : Text('LOG IN'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _key,
            autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      filled: true,
                      isDense: true,
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) {
                      return (value == null || value.isEmpty) ? 'Email is required.' : null;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      isDense: true,
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      return (value == null || value.isEmpty) ? 'Password is required.' : null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildSubmitButton(context, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }
}
