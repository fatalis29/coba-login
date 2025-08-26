import 'package:dbank/routes/routes.dart';
import 'package:dbank/viewmodels/dashboard/notification_viewmodel.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const AppBarTitle(title: 'Notifikasi'),
        centerTitle: true,
        shadowColor: Theme.of(context).colorScheme.shadow,
        leading: IconButton(icon: Icon(Icons.chevron_left, color: Theme.of(context).colorScheme.primary), onPressed: () => context.pop()),
      ),
      body: ChangeNotifierProvider<NotificationViewModel>(
        create: (context) => NotificationViewModel(),
        child: Consumer<NotificationViewModel>(
          builder: (context, viewModel, child) {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 10, // TODO: get count from viewmodel
              itemBuilder: (context, index) {
                return ListTile(
                  key: key,
                  title: Text('Notification title test', style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text('Notification subtitle test', style: TextStyle(fontSize: 12, color: Colors.grey),),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.pushNamed(Routes.detailNotifikasi.routeName, pathParameters: {'id': index.toString()}),
                );
              }
            );
          }
        )
      ),
    );
  }
}