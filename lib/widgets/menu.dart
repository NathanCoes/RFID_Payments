import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.activeLayout,
  });

  final void Function(BuildContext context, String screen) activeLayout;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: (){activeLayout(context, "users");}, 
          child: const Text("Usuarios")
        ),
        ElevatedButton(
          onPressed: (){activeLayout(context, "transactions");}, 
          child: const Text("Transacciones")
        ),
        ElevatedButton(
          onPressed: (){activeLayout(context, "bracelete");}, 
          child: const Text("Brazaletes")
        ),
        ElevatedButton(
          onPressed: (){activeLayout(context, "pos");}, 
          child: const Text("POS")
        ),
      ],
    );
  }
}