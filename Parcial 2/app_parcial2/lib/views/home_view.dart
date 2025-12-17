import 'package:flutter/material.dart';
import 'package:app_parcial2/services/theme_service.dart';
import 'package:app_parcial2/views/colors_view.dart';  
import 'package:app_parcial2/views/inputs_view.dart'; 

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var themeStatus = themeMode.value == 'light';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
        elevation: 10, 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              const Text(
                '¡Bienvenido👋',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 13, 228, 228),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Descubre nuestros productos y añade nuevos artículos a la tienda.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              
              _buildAnimatedButton(
                context,
                'Agregar Producto',
                Colors.blue,
                Colors.white,
                Icons.add_circle_outline, 
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InputsView()),
                  );
                },
              ),
              const SizedBox(height: 20),
              
              // Cambié "Ver Categorías" por "Método de Pago" con un icono de pago
              _buildAnimatedButton(
                context,
                'Método de Pago',
                Colors.green,
                Colors.white,
                Icons.payment,  // Icono relacionado con pago
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ColorsView()), // Cambiar esta vista si es necesario
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (themeStatus) {
            themeMode.value = 'dark';
          } else {
            themeMode.value = 'light';
          }
        },
        tooltip: 'Switch theme',
        child: Icon(
          themeStatus ? Icons.sunny : Icons.mode_night_outlined,
        ),
      ),
    );
  }

  // Método para crear botones animados con iconos
  Widget _buildAnimatedButton(
    BuildContext context,
    String text,
    Color bgColor,
    Color textColor,
    IconData icon, 
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 28), 
            const SizedBox(width: 10), 
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
