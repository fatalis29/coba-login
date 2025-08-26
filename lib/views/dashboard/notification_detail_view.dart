import 'package:dbank/viewmodels/dashboard/notification_detail_viewmodel.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NotificationDetailView extends StatelessWidget {
  final String notificationId;
  NotificationDetailView({super.key, required this.notificationId});

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
      body: ChangeNotifierProvider<NotificationDetailViewModel>(
        create: (context) => NotificationDetailViewModel(notificationId: notificationId),
        child: Consumer<NotificationDetailViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(viewModel.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text(viewModel.time, 
                    style: const TextStyle(
                      wordSpacing: 2,
                      letterSpacing: 1,
                      fontSize: 12
                    )
                  ),
                  const SizedBox(height: 24),
                  (viewModel.imgSrc != null) ? Image.network(
                    viewModel.imgSrc as String,
                  ) : const SizedBox(),
                  const SizedBox(height: 24),
                  Text.rich(TextSpan(text: viewModel.body)) 
                ],
              ),
            );
          },
        ),
      )
    );
  }
}