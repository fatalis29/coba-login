import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dbank/routes/route.dart' as app_route;
import 'package:dbank/routes/routes.dart';

/// A floating widget for developers to easily navigate between pages for testing.
/// It displays a button that expands into a scrollable list of all available routes.
class DevPageNavigator extends StatefulWidget {
  const DevPageNavigator({super.key});

  @override
  State<DevPageNavigator> createState() => _DevPageNavigatorState();
}

class _DevPageNavigatorState extends State<DevPageNavigator> {
  bool _isExpanded = false;

  // A complete list of all routes defined in your Routes class.
  // You must manually keep this list updated if you add/remove routes.
  final List<app_route.Route> _allRoutes = [
    Routes.login,
    Routes.dashboard,
    Routes.qrStatis,
    Routes.inputNominalTransaksi,
    Routes.qrNominalTransaksi,
    Routes.success,
    Routes.failed,
    Routes.riwayatTransaksi,
    Routes.detailRiwayatTransaksi,
    Routes.refund,
    Routes.konfirmasiRefund,
    Routes.notifikasi,
    Routes.detailNotifikasi,
    Routes.pengaturan,
    Routes.profil,
    Routes.ubahPin,
  ];

  /// Handles navigation logic.
  /// It checks for path parameters (like ':id') and provides a default value.
  void _navigateTo(app_route.Route route) {
    // For routes with path parameters, provide a mock value.
    if (route.routeUrl.contains(':id')) {
      context.pushNamed(
        route.routeName,
        pathParameters: {'id': 'dev-id-123'}, // Mock ID for testing
      );
    } else {
      context.pushNamed(route.routeName);
    }
    // Collapse the panel after navigating
    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Positioned allows the widget to float over your screen's content.
    return Positioned(
      bottom: 20,
      right: 20,
      child: Material(
        elevation: 6.0,
        borderRadius: BorderRadius.circular(16.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _isExpanded ? 400 : 56,
          width: _isExpanded ? 280 : 56,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: _isExpanded ? _buildExpandedView() : _buildCollapsedView(),
        ),
      ),
    );
  }

  /// The small, collapsed floating action button.
  Widget _buildCollapsedView() {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: () => setState(() => _isExpanded = true),
      child: const Center(
        child: Icon(Icons.route_rounded, semanticLabel: 'Open Page Navigator'),
      ),
    );
  }

  /// The expanded view with the scrollable list of routes.
  Widget _buildExpandedView() {
    return Column(
      children: [
        // Header with title and collapse button
        ListTile(
          title: const Text('Page Navigator', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => setState(() => _isExpanded = false),
          ),
          contentPadding: const EdgeInsets.only(left: 16.0, right: 8.0),
        ),
        const Divider(height: 1),
        // Scrollable list of routes
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _allRoutes.length + 1, // +1 for the 'Go Back' button
            itemBuilder: (context, index) {
              // Add a "Go Back" button at the beginning of the list
              if (index == 0) {
                return ListTile(
                  leading: const Icon(Icons.arrow_back, color: Colors.orange),
                  title: const Text('Go Back (Pop)'),
                  onTap: () {
                    if (context.canPop()) context.pop();
                    setState(() => _isExpanded = false);
                  },
                );
              }
              final route = _allRoutes[index - 1];
              return ListTile(
                title: Text(route.routeName, style: const TextStyle(fontSize: 14)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () => _navigateTo(route),
              );
            },
          ),
        ),
      ],
    );
  }
}