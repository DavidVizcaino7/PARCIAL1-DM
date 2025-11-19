import 'package:flutter/material.dart';
import 'Profile_1/profile.dart';
import 'Settings_2/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Página seleccionada (Índice)
  int selectedIndex = 0;

  // Listado de las pantallas (5 pantallas)
  final List<Widget> listPage = [
    const Settings(title: 'Settings'),
    const Profile(title: 'User'),
    const Placeholder(), // Puedes reemplazar esto con una pantalla real
    const Placeholder(), // Otra pantalla de ejemplo
    const Placeholder(), // Otra pantalla de ejemplo
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        backgroundColor: Colors.purple,
        elevation: 4,
      ),
      body: listPage[selectedIndex], // Página según el índice seleccionado
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            
            Container(
              height: 200, 
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/imagenes/you.jpg'), 
                  fit: BoxFit.cover, 
                ),
              ),
            ),
           
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.purple),
              title: const Text('Settings'),
              onTap: () {
                setState(() {
                  selectedIndex = 0; // Seleccionar página de Configuración
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, color: Colors.purple),
              title: const Text('Profile'),
              onTap: () {
                setState(() {
                  selectedIndex = 1; // Seleccionar página de Perfil
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.purple),
              title: const Text('Option 3'),
              onTap: () {
                setState(() {
                  selectedIndex = 2; // Seleccionar tercera página
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search, color: Colors.purple),
              title: const Text('Option 4'),
              onTap: () {
                setState(() {
                  selectedIndex = 3; // Seleccionar cuarta página
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications, color: Color.fromARGB(255, 18, 4, 20)),
              title: const Text('Option 5'),
              onTap: () {
                setState(() {
                  selectedIndex = 4; // Seleccionar quinta página
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex, // Indice actual
        onTap: (int index) {
          setState(() {
            selectedIndex = index; // Cambiar la página seleccionada
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Option 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Option 4',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Option 5',
          ),
        ],
      ),
    );
  }
}
