import 'package:go_router/go_router.dart';
import '../../features/order/presentation/ui/screens/customer_info_screen.dart';
import '../../features/order/presentation/ui/screens/package_details_screen.dart';
import '../../features/order/presentation/ui/screens/payment_screen.dart';
import '../../features/order/presentation/ui/screens/review_screen.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a GoRouter object that defines the routes for the application.
final GoRouter router = GoRouter(
  initialLocation: '/customer-info',
  routes: [
    GoRoute(
      path: '/customer-info',
      builder: (context, state) => const CustomerInfoScreen(),
    ),
    GoRoute(
      path: '/package-details',
      builder: (context, state) => const PackageDetailsScreen(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => const PaymentScreen(),
    ),
    GoRoute(path: '/review', builder: (context, state) => const ReviewScreen()),
  ],
);
