import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/widgets/fondo_login.dart';
import 'package:productos_app/widgets/card_container.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FondoLogin(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250,),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text(
                      'Iniciar Sesión',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 20,),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm() ,
                    ),
                    SizedBox(height: 30,),
                  ],
                )
              ),
              SizedBox(height: 50,),
              Text(
                'Crear una nueva cuenta',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
             ],
          ),
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  //const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
  
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
                labelText: 'Correo Electrónico',
                hintText: 'ejemplo: juan@gmail.com',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  ),
                  prefixIcon: Icon(
                    Icons.alternate_email_sharp,
                    color: Colors.deepPurple,
                  )
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                ? null
                : 'El correo no es válido';
              },
            ),
            SizedBox(height: 30,),
             TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
                labelText: 'Contraseña',
                hintText: '********',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.deepPurple,
                  ),
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                } else {
                  return 'La contraseña debe de ser de 6 caracteres';
                }
              },
            ),
            SizedBox(height: 30,),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 15,
                ),
                child: Text(
                  loginForm.isLoading ? 'Espere...' : 'Ingresar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed:
              loginForm.isLoading
              ? null
              : () async {
                FocusScope.of(context).unfocus();
                if (!loginForm.isValidForm()) return;
                loginForm.isLoading = true;
                await Future.delayed(Duration(seconds: 2));
                loginForm.isLoading = false;
                Navigator.pushReplacementNamed(context, 'home');
              }, 
            )
          ],
        )
      )
    );
  }
}