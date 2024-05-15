import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_bloc.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_event.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_state.dart';
import 'package:go_router/go_router.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<UsuarioBloc, UsuarioState>(
        listener: (context, state) {
          if (state is UsuarioLoaded) {
            context.go('/home_admin', extra: state.usuario);
          } else if (state is UsuarioError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.go('/');
              },
              backgroundColor: Colors.white.withOpacity(0.5),
              child: const Icon(Icons.arrow_back),
            ),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(213, 227, 232, 1),
                      Color.fromRGBO(70, 169, 178, 1)
                    ]),
                  ),
                  width: double.infinity,
                  height: size.height * 1,
                ),
                SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: double.infinity,
                    child: const Icon(
                      Icons.person_pin_rounded,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
                SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 230,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            )
                          ]),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Center(
                              child: Text(
                            'Ingreso Administrador',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          // style: Theme.of(context).textTheme.headlineLarge)),
                          const SizedBox(height: 30),
                          Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    hintText: 'ejemplo@gmail.com',
                                    labelText: 'Correo Electronico',
                                    icon: Icon(Icons.alternate_email_outlined),
                                  ),
                                  validator: (value) {
                                    String pattern =
                                        r'^(([^<>()\[\]\.,;:\s@\”]+(\.[^<>()\[\]\.,;:\s@\”]+)*)|(\”.+\”))@(([^<>()[\]\.,;:\s@\”]+\.)+[^<>()[\]\.,;:\s@\”]{2,})$';
                                    RegExp regExp = RegExp(pattern);
                                    return regExp.hasMatch(value ?? '')
                                        ? null
                                        : 'El correo electronico no existe';
                                  },
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  autocorrect: false,
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    hintText: '******',
                                    labelText: 'Contraseña',
                                    icon: Icon(Icons.lock_outline_rounded),
                                  ),
                                  validator: (value) {
                                    return (value != null && value.length >= 6)
                                        ? null
                                        : 'La contraseña debe tener un minimo de 6 caracteres';
                                  },
                                ),
                                const SizedBox(height: 50),
                                MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    disabledColor: Colors.grey,
                                    color: Colors.cyan,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 80,
                                        vertical: 15,
                                      ),
                                      child: const Text(
                                        'Ingresar',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<UsuarioBloc>(context).add(
                                        UsuarioLoginEvent(
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                        ),
                                      );
                                    })
                              ])),
                        ],
                      ),
                    )
                  ],
                ))
              ]),
            )));
  }
}
