import 'package:flutter/material.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class PayPalWebView extends StatefulWidget {
  final String subscriptionUrl;

  const PayPalWebView({Key? key, required this.subscriptionUrl})
      : super(key: key);

  @override
  State<PayPalWebView> createState() => _PayPalWebViewState();
}

class _PayPalWebViewState extends State<PayPalWebView> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayPal Payment'),
        backgroundColor: AppColors.lilacPurple,
        titleTextStyle: const TextStyle(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: WebView(
        initialUrl: widget.subscriptionUrl,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://your.redirect.url')) {
            // Handle PayPal response
            Get.back(result: request.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
