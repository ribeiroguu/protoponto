import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/welcome_page.dart';
import 'models/punch_record.dart';
import 'services/punch_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PunchRecordAdapter());

  final punchService = PunchService();
  await punchService.init();

  runApp(MyApp(punchService: punchService));
}

class MyApp extends StatelessWidget {
  final PunchService punchService;

  const MyApp({required this.punchService, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(punchService: punchService),
    );
  }
}
