import 'package:battery_bay_test/constant/app_theme.dart';
import 'package:battery_bay_test/controllers/login_provider.dart';
import 'package:battery_bay_test/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'controllers/register_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await dotenv.load(fileName: ".env"); // Load environment variables

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterProvider()), // Add Provider Here
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // Ensure correct screen scaling
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: "/register",
            onGenerateRoute: Routes.generateRoute,
            theme: appTheme,
            builder: (context, widget) {
              if (widget == null) return const SizedBox(); // Fix null widget issue
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                child: widget,
              );
            },
          );
        },
      ),
    );
  }
}
