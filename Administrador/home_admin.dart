import 'dart:async';

import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  final Usuario usuario;

  HomePage({super.key, required this.usuario});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: true, viewportFraction: 1);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;
        if (nextPage == listCard.length) {
          _pageController.jumpToPage(0);
        } else {
          _pageController.animateToPage(nextPage,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeIn);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        usuario: widget.usuario,
        title: "Inicio",
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(255, 231, 233, 1),
            Color.fromRGBO(70, 169, 178, 1)
          ])),
          child: SingleChildScrollView(
              child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Bienvenido ${widget.usuario.nameUser}',
                  style: const TextStyle(
                      fontSize: 26,
                      color: Color.fromARGB(255, 78, 75, 75),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Productos disponibles a la venta',
                style: TextStyle(
                    color: Color.fromARGB(255, 68, 65, 65), fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 350,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, -2))
              ]),
              child: PageView.builder(
                controller: _pageController,
                itemCount: listCard.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        context.go('/card');
                      },
                      child: Image.network(
                        listCard[index]['imagen']!,
                        fit: BoxFit.cover,
                      ));
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: listCard.length,
                  effect: WormEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    activeDotColor: Theme.of(context).colorScheme.secondary,
                    dotColor: Colors.grey,
                  ),
                )),
          ])),
        ));
  }
}
