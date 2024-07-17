import 'package:castro_axell_leccion/ui/castro_axell_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CastroAxellLogin extends StatefulWidget {
  const CastroAxellLogin({super.key});

  @override
  State<CastroAxellLogin> createState() => _CastroAxellLoginState();
}

class _CastroAxellLoginState extends State<CastroAxellLogin> {
  final usuarioController = TextEditingController();
  final claveController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  void handleLogin() {
    if (usuarioController.text.isEmpty || claveController.text.isEmpty) {
      _showAlert('Por favor ingrese su usuario y clave.');
    } else if (usuarioController.text == 'admin' &&
        claveController.text == '999') {
      // Navigate to the next screen or show a success message
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CastroAxellNavigation(),
        ),
      );
    } else {
      _showAlert('Usuario o clave incorrectos.');
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Center(
          child: Text(
            'Lección Segundo Parcial  DAM 8-2',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      _textCustom(
                        context,
                        label: 'Email',
                        font: 'Montserrat',
                      ),
                      const SizedBox(height: 10),
                      _buildInputField(
                        context,
                        controller: usuarioController,
                        hintText: 'username',
                        icon: Icons.mail,
                      ),
                      const SizedBox(height: 30),
                      _textCustom(
                        context,
                        label: 'Clave',
                        font: 'Montserrat',
                      ),
                      const SizedBox(height: 10),
                      _buildInputField(context,
                          controller: claveController,
                          hintText: '*************',
                          icon: Icons.lock,
                          isPassword: true,
                          showPassword: showPassword,
                          togglePasswordVisibility: () {
                        setState(() => showPassword = !showPassword);
                      }),
                      const SizedBox(height: 30),
                      _buildButton(
                        context,
                        buttonText: "Conectar ",
                        onPressed: handleLogin,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Realizado por el futuro Ing. En Software Axell Castro',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _textCustom(
  BuildContext context, {
  required String label,
  required String font,
}) {
  return Text(
    label,
    style: GoogleFonts.getFont(
      font,
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: Colors.black87,
    ),
  );
}

Widget _buildInputField(
  BuildContext context, {
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  bool isPassword = false,
  bool showPassword = false,
  VoidCallback? togglePasswordVisibility,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.black),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: isPassword && !showPassword,
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        prefixIcon: Icon(icon, color: Colors.black),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: togglePasswordVisibility,
              )
            : null,
        border: InputBorder.none,
      ),
    ),
  );
}

Widget _buildButton(
  BuildContext context, {
  required String buttonText,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18),
      ),
      child: Text(
        buttonText,
        style: GoogleFonts.outfit(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
