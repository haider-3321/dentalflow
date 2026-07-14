import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'config/theme/app_theme.dart';
import 'config/localization/app_localization.dart';
import 'config/routes/app_routes.dart';
import 'core/services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize GetStorage
  await GetStorage.init();
  
  // Initialize Supabase
  await SupabaseService.initialize();
  
  runApp(const DentalFlowApp());
}

class DentalFlowApp extends StatelessWidget {
  const DentalFlowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DentalFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      supportedLocales: const [Locale('en'), Locale('ar')],
      locale: Locale(GetStorage().read<String>('language') ?? 'en'),
      fallbackLocale: const Locale('en'),
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.splash,
    );
  }
}
