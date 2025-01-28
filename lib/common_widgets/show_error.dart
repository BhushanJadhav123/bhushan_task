import 'package:flutter/material.dart';

class ShowErrorWidget extends StatelessWidget {
  const ShowErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onPress,
  });
  final String errorMessage;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 16),
          ),
          ElevatedButton(onPressed: onPress, child: const Text("Retry"))
        ],
      ),
    );
  }
}
