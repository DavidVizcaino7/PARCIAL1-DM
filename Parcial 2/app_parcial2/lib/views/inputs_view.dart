import 'package:flutter/material.dart';

class InputsView extends StatefulWidget {
  const InputsView({super.key});

  @override
  State<InputsView> createState() => _InputsViewState();
}

class _InputsViewState extends State<InputsView> {
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final productQuantityController = TextEditingController();

  bool isFeaturedProduct = false;
  bool isAvailableForDelivery = false;
  String selectedCategory = 'Productos de Limpieza';

  final _formKey = GlobalKey<FormState>(); // Clave del formulario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Producto'),
        backgroundColor: const Color.fromARGB(255, 11, 192, 224),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Asignar la clave para validación
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assents/imagenes/Mercado.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Detalles del Producto',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 129, 194),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Llena los detalles del producto a continuación.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),

              // Nombre del Producto
              _buildTextField(
                label: 'Nombre del Producto',
                hint: 'Ingresa el nombre del producto',
                icon: Icons.shopping_bag,
                controller: productNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del producto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Descripción del Producto
              _buildTextField(
                label: 'Descripción del Producto',
                hint: 'Detalles sobre el producto (ej. Camiseta negra)',
                icon: Icons.description,
                controller: productDescriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la descripción del producto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Precio del Producto
              _buildTextField(
                label: 'Precio del Producto',
                hint: 'Ingresa el precio del producto',
                icon: Icons.monetization_on,
                controller: productPriceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el precio del producto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Cantidad del Producto
              _buildTextField(
                label: 'Cantidad',
                hint: 'Número de unidades disponibles',
                icon: Icons.confirmation_number,
                controller: productQuantityController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la cantidad del producto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Checkbox para "Producto Destacado"
              CheckboxListTile(
                title: const Text('Producto Destacado'),
                value: isFeaturedProduct,
                onChanged: (bool? value) {
                  setState(() {
                    isFeaturedProduct = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.purple,
              ),

              // Checkbox para "Disponible para Entrega"
              CheckboxListTile(
                title: const Text('Disponible para Entrega'),
                value: isAvailableForDelivery,
                onChanged: (bool? value) {
                  setState(() {
                    isAvailableForDelivery = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.purple,
              ),

              const SizedBox(height: 20),

              // Dropdown para seleccionar la categoría del producto
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Seleccionar Categoría',
                  border: OutlineInputBorder(),
                ),
                items: ['Productos de Limpieza', 'Comida', 'Lácteos', 'Verduras', 'Carnes']
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (String? newCategory) {
                  setState(() {
                    selectedCategory = newCategory ?? 'Productos de Limpieza';
                  });
                },
              ),
              const SizedBox(height: 30),

              // Botón de envío para guardar el producto
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validar el formulario antes de enviarlo
                    if (_formKey.currentState?.validate() ?? false) {
                      // Simular el guardado del producto
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Producto guardado con éxito!')),
                      );
                    }
                  },
                  child: Text('Guardar Producto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para crear TextFields con íconos y bordes redondeados
  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      validator: validator,
    );
  }
}
