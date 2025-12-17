import 'package:flutter/material.dart';
import 'package:app_1/models/characters_model.dart'; 
import 'package:http/http.dart' as http;

class HttpView extends StatefulWidget {
  const HttpView({super.key});

  @override
  State<HttpView> createState() => _HttpViewState();
}

class _HttpViewState extends State<HttpView> {
  final TextEditingController _controller = TextEditingController(); // Controlador para el campo de texto
  String characterId = '5'; // Número del personaje inicial
  late Future<CharacterModel> _characterModel; // Variable para almacenar el modelo del personaje

  // Función que devuelve el modelo completo desde la API, con el número del personaje como parámetro
  Future<CharacterModel> fetchData(String characterId) async {
    var url = Uri.https('thesimpsonsapi.com', 'api/characters/$characterId'); // Usar el characterId
    var response = await http.get(url);
    return characterModelFromJson(response.body); // Convierte el JSON a un modelo
  }

  // Inicialización del Future _characterModel en el initState
  @override
  void initState() {
    super.initState();
    _characterModel = fetchData(characterId); // Inicializa el Future con el personaje inicial
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simpsons Character"),
        backgroundColor: Colors.purple,  // Color de la barra superior
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
              children: [
                // Campo de texto para ingresar el número del personaje
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Número del Personaje',
                      hintText: 'Escribe el número del personaje',
                      labelStyle: const TextStyle(color: Colors.purple),
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        characterId = value; // Actualiza el número del personaje mientras se escribe
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Botón de búsqueda para obtener el personaje
                ElevatedButton(
                  onPressed: () {
                    if (characterId.isNotEmpty) {
                      setState(() {
                        _characterModel = fetchData(characterId); // Actualiza la solicitud de datos con el ID ingresado
                      });
                    } else {
                      // Si el campo está vacío, muestra un mensaje de error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Por favor ingresa un número de personaje')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Cambié 'primary' a 'backgroundColor'
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Buscar Personaje',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),

                // Mostrar los datos del personaje
                FutureBuilder<CharacterModel>(
                  future: _characterModel, // Llamada a la función que devuelve los datos
                  builder: (BuildContext context, AsyncSnapshot<CharacterModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Muestra un cargando
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ); // Muestra error si ocurre
                    } else if (snapshot.hasData) {
                      // Muestra la información del personaje
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),  // Bordes redondeados para la imagen
                            child: Image.network(
                              "https://cdn.thesimpsonsapi.com/500${snapshot.data?.portraitPath}",
                              height: 250,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Nombre: ${snapshot.data!.name}',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Ocupación: ${snapshot.data!.occupation}',
                            style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white70),
                          ),
                        ],
                      );
                    } else {
                      return const Text(
                        'No data available',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ); // Si no hay datos
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
