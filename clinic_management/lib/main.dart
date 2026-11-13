import 'package:flutter/material.dart';

import 'Dashboard.dart';

void main(){
  runApp(ClinicMan());
}

class ClinicMan extends StatelessWidget {
  const ClinicMan({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}

