import 'package:get/get.dart';
import 'package:dentalflow/presentation/pages/splash/splash_screen.dart';
import 'package:dentalflow/presentation/pages/auth/login_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String adminDashboard = '/admin-dashboard';
  static const String doctorDashboard = '/doctor-dashboard';
  static const String secretaryDashboard = '/secretary-dashboard';
  static const String appointments = '/appointments';
  static const String patients = '/patients';
  static const String patientDetails = '/patient-details';
  static const String doctors = '/doctors';
  static const String secretaries = '/secretaries';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String createAppointment = '/create-appointment';
  static const String editAppointment = '/edit-appointment';

  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
