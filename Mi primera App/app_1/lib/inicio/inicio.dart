import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Importar Lottie
import 'package:app_1/services/theme_service.dart'; 
import 'package:app_1/Profile_1/http.view.dart'; 
import 'package:app_1/Settings_2/catalogo.dart';  // Asegúrate de importar el catalogo.dart

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    var themeStatus = themeMode.value == 'light'; 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,  
        title: const Text('Main'),
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  '¡Bienvenido👋',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Descubre las diferentes funcionalidades.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),

                
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Lottie.asset(
                    'assets/imagenes/cat.json',  // Asegúrate de colocar 'cat.json' en la ruta correcta
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 40),

                // Botones animados
                _buildAnimatedButton(
                  context,
                  'Ver Personaje',
                  Colors.purple.shade700,
                  Colors.white,
                  Icons.account_circle, 
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const HttpView()), // Navegar a HttpView
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Cambié 'Ajustes' por 'Formulario'
                _buildAnimatedButton(
                  context,
                  'Formulario',
                  Colors.green.shade700,
                  Colors.white,
                  Icons.description,  
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const CatalogoView()), // Navegar a CatalogoView
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (themeStatus) {
            themeMode.value = 'dark'; // Cambiar el tema a oscuro
          } else {
            themeMode.value = 'light'; // Cambiar el tema a claro
          }
        },
        tooltip: 'Cambiar tema',
        backgroundColor: Colors.purple,  // Cambié el color del FAB
        child: Icon(
          themeStatus ? Icons.sunny : Icons.mode_night_outlined, // Usamos la variable themeStatus aquí
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
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 40.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(40.0),  // Bordes más redondeados
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 6),  // Desplazamiento más suave para la sombra
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 28), 
            const SizedBox(width: 12), 
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 20,  // Aumenté el tamaño de fuente para mayor visibilidad
                fontWeight: FontWeight.w600,  // Fuente más gruesa
              ),
            ),
          ],
        ),
      ),
    );
  }
}
