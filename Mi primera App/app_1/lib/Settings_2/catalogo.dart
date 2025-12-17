import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Importar Lottie

class CatalogoView extends StatefulWidget {
  const CatalogoView({super.key});

  @override
  State<CatalogoView> createState() => _CatalogoViewState();
}

class _CatalogoViewState extends State<CatalogoView> {
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final productQuantityController = TextEditingController();

  bool isFeaturedProduct = false;
  bool isAvailableForDelivery = false;
  String selectedCategory = 'Electrónica';

  // Controladores del formulario de pago
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final customAmountController = TextEditingController();

  // Variables del formulario de pago
  bool? checkboxValue = false; // Aceptación de términos y condiciones
  double amountToPay = 0; // Monto a pagar
  double customAmount = 0; // Monto personalizado
  String selectedPaymentMethod = 'Tarjeta de Crédito'; // Método de pago seleccionado
  String selectedCurrency = 'USD'; // Moneda seleccionada
  String paymentStatus = ''; // Estado del pago

  final _formKey = GlobalKey<FormState>(); // Clave para validación del formulario

  @override
  void dispose() {
    // Limpieza de los controladores cuando no se necesiten
    productNameController.dispose();
    productDescriptionController.dispose();
    productPriceController.dispose();
    productQuantityController.dispose();
    nameController.dispose();
    emailController.dispose();
    customAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple, // Mantenemos el color púrpura
        title: const Text('Catálogo de Productos'),
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
            child: Form(
              key: _formKey, // Asignar la clave para validación
              child: ListView(
                children: [
                  // --- Animación Lottie reemplazando la imagen ---
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Lottie.asset(
                      'assets/imagenes/Food.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 120),

                  const Text(
                    'Detalles del Producto',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Llena los detalles del producto a continuación.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
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
                    hint: 'Detalles sobre el producto (ej. Televisor 55 pulgadas)',
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

                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Seleccionar Categoría',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Electrónica', 'Ropa', 'Alimentos', 'Muebles', 'Juguetes']
                        .map((category) => DropdownMenuItem<String>(value: category, child: Text(category)))
                        .toList(),
                    onChanged: (String? newCategory) {
                      setState(() {
                        selectedCategory = newCategory ?? 'Electrónica';
                      });
                    },
                  ),
                  const SizedBox(height: 30),

                  // --- FORMULARIO DE PAGO ---
                  const Text(
                    'Detalles del Pago',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    label: 'Nombre Completo',
                    hint: 'Ingresa tu nombre completo',
                    icon: Icons.person,
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre completo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    label: 'Correo Electrónico',
                    hint: 'Ingresa tu correo electrónico',
                    icon: Icons.email,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo electrónico';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    value: selectedPaymentMethod,
                    decoration: const InputDecoration(
                      labelText: 'Método de Pago',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Tarjeta de Crédito', 'PayPal', 'Efectivo']
                        .map((method) => DropdownMenuItem<String>(value: method, child: Text(method)))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPaymentMethod = newValue ?? 'Tarjeta de Crédito';
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  Column(
                    children: [
                      Text('Monto a pagar: \$${amountToPay.toStringAsFixed(2)}'),
                      Slider(
                        value: amountToPay,
                        min: 0,
                        max: 500,
                        label: "Monto a pagar",
                        onChanged: (value) {
                          setState(() {
                            amountToPay = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  CheckboxListTile(
                    title: const Text('Acepto los términos y condiciones'),
                    value: checkboxValue,
                    onChanged: (bool? value) {
                      setState(() {
                        checkboxValue = value;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.purple,
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (checkboxValue == true) {
                          setState(() {
                            paymentStatus = 'Pago realizado con éxito!';
                          });
                        } else {
                          setState(() {
                            paymentStatus = 'Debe aceptar los términos y condiciones';
                          });
                        }
                      }
                    },
                    child: const Text('Pagar'),
                  ),
                  const SizedBox(height: 20),

                  if (paymentStatus.isNotEmpty)
                    Text(
                      paymentStatus,
                      style: TextStyle(
                        color: paymentStatus.contains('éxito') ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
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
