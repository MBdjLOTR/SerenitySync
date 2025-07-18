// lib/utils/notification_dialog.dart
import 'package:flutter/material.dart';

Future<void> showNotificationConfirmation(BuildContext context, String time) async {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Reminder Set ✅',
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        'You’ll be reminded daily at $time to relax and meditate.',
        style: const TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          child: const Text('OK', style: TextStyle(color: Colors.tealAccent)),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    ),
  );
}
