import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter/gestures.dart';

class Settings extends StatelessWidget {
  const Settings({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final ScrollController horizontalController = ScrollController();

    
    final List<Color> colors = [
      Colors.blue.shade200,
      Colors.green.shade200,
      Colors.red.shade200,
      Colors.orange.shade200,
      Colors.pink.shade200,
      Colors.yellow.shade200,
      Colors.cyan.shade200,
      Colors.teal.shade200,
      Colors.indigo.shade200,
    ];

    
    final List<IconData> icons = [
      Icons.home,
      Icons.settings,
      Icons.account_circle,
      Icons.favorite,
      Icons.notifications,
      Icons.search,
      Icons.camera,
      Icons.lock,
      Icons.star,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 4,
      ),
      backgroundColor: Colors.white, 
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, 
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  itemCount: 9,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    // Tamaños variables de cuadros
                    double height = (index % 3 + 1) * 100.0; // Diferentes alturas

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      height: height,
                      decoration: BoxDecoration(
                        color: colors[index], // Colores diferentes para cada cuadro
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          icons[index], // Iconos diferentes para cada cuadro
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Sección de desplazamiento horizontal (Filas)
              Focus(
                autofocus: true,
                onKeyEvent: (node, event) {
                  if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                    horizontalController.animateTo(
                      horizontalController.offset + 100,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                    );
                    return KeyEventResult.handled;
                  } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                    horizontalController.animateTo(
                      horizontalController.offset - 100,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                    );
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200, // Fondo gris claro
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: ListView.builder(
                      controller: horizontalController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        // Tamaños variables de cuadros
                        double width = (index % 3 + 1) * 120.0; // Diferentes anchos

                        return Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: width,
                          decoration: BoxDecoration(
                            color: colors[index % colors.length], // Colores diferentes
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(
                              icons[index % icons.length], // Iconos diferentes
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
