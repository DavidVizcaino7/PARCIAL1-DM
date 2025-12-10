import 'package:flutter/material.dart';

class ColorsView extends StatefulWidget {
  const ColorsView({super.key});

  @override
  _ColorsViewState createState() => _ColorsViewState();
}

class _ColorsViewState extends State<ColorsView> {
  bool? checkboxValue = false; // Aceptación de términos y condiciones
  double amountToPay = 0; // Monto a pagar
  double customAmount = 0; // Monto personalizado
  String selectedPaymentMethod = 'Tarjeta de Crédito'; // Método de pago seleccionado
  String selectedCurrency = 'USD'; // Moneda seleccionada
  String paymentStatus = ''; // Estado del pago

  final nameController = TextEditingController(); // Controlador para el nombre
  final emailController = TextEditingController(); // Controlador para el email
  final customAmountController = TextEditingController(); // Controlador para monto personalizado

  final _formKey = GlobalKey<FormState>(); // Clave para validación del formulario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Pago'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Asignar la clave para validación
            child: Column(
              children: [
                // Título del formulario
                const Text(
                  'Formulario de Pago',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 20),

                // Nombre del comprador
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text('Nombre Completo'),
                      border: OutlineInputBorder(),
                      helperText: "Es necesario tu nombre completo",
                      hintText: 'John Doe',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre';
                      }
                      return null;
                    },
                  ),
                ),

                // Correo electrónico del comprador
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: Text('Correo Electrónico'),
                      border: OutlineInputBorder(),
                      helperText: "Introduce tu correo electrónico",
                      hintText: 'ejemplo@correo.com',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un correo electrónico';
                      } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value)) {
                        return 'Correo electrónico inválido';
                      }
                      return null;
                    },
                  ),
                ),

                // Método de pago
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedPaymentMethod,
                    decoration: const InputDecoration(
                      labelText: 'Método de Pago',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Tarjeta de Crédito', 'PayPal', 'Efectivo']
                        .map((method) => DropdownMenuItem<String>(
                              value: method,
                              child: Text(method),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPaymentMethod = newValue ?? 'Tarjeta de Crédito';
                      });
                    },
                  ),
                ),

                // Selección de la moneda
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedCurrency,
                    decoration: const InputDecoration(
                      labelText: 'Seleccionar Moneda',
                      border: OutlineInputBorder(),
                    ),
                    items: ['USD', 'EUR', 'MXN', 'ARS']
                        .map((currency) => DropdownMenuItem<String>(
                              value: currency,
                              child: Text(currency),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue ?? 'USD';
                      });
                    },
                  ),
                ),

                // Monto a pagar (Slider)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                ),

                // Campo para monto personalizado
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: customAmountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Monto Personalizado'),
                      border: OutlineInputBorder(),
                      hintText: 'Escribe un monto',
                      prefixIcon: Icon(Icons.money),
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final customValue = double.tryParse(value);
                        if (customValue == null || customValue < 0) {
                          return 'Monto no válido';
                        }
                      }
                      return null;
                    },
                  ),
                ),

                // Aceptación de términos y condiciones
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

                // Botón de pago
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (checkboxValue == true) {
                          setState(() {
                            paymentStatus = 'Pago realizado con éxito!';
                          });
                          print(paymentStatus);
                        } else {
                          setState(() {
                            paymentStatus = 'Debe aceptar los términos y condiciones';
                          });
                          print(paymentStatus);
                        }
                      }
                    },
                    child: Text('Pagar'),
                  ),
                ),

                // Mostrar el resumen del pago
                if (paymentStatus.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      paymentStatus,
                      style: TextStyle(
                        color: paymentStatus.contains('éxito') ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
