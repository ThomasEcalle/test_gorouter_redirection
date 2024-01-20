import 'package:flutter/material.dart';

import '../fake_analytics_logger.dart';

class ProtectedScreen extends StatefulWidget {
  const ProtectedScreen({super.key});

  @override
  State<ProtectedScreen> createState() => _ProtectedScreenState();
}

class _ProtectedScreenState extends State<ProtectedScreen> {
  @override
  void initState() {
    super.initState();
    FakeAnalyticsLogger.log('Protected screen');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('ProtectedScreen'),
      ),
    );
  }
}
