import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

class LoginClient extends StatefulWidget {
  const LoginClient({super.key});

  @override
  _LoginClientState createState() => _LoginClientState();
}

class _LoginClientState extends State<LoginClient> {
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
    return BlocListener<LoginClientBloc, ClienteState>(
        listener: (context, state) {
          if (state is ClienteCargado) {
            context.go('/home_client', extra: state.cliente);
          } else if (state is ClientesError) {
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
                      Color.fromRGBO(225, 231, 233, 1),
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
                            'Ingreso Cliente',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
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
                                    color:
                                        const Color.fromARGB(255, 53, 208, 229),
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
                                      BlocProvider.of<LoginClientBloc>(context)
                                          .add(
                                        ClientLoginEvent(
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
