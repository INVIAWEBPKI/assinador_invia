import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCustomWidget extends StatefulWidget {
  final String url;
  const WebViewCustomWidget({super.key, required this.url});

  @override
  State<WebViewCustomWidget> createState() => _WebViewCustomWidgetState();
}

class _WebViewCustomWidgetState extends State<WebViewCustomWidget> {
  late final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(widget.url));
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.url.isNotEmpty) {
          return WebViewWidget(controller: controller);
        } else {
          return Center(
            child: Text("url inválida!"),
          );
        }
      },
    );
  }
}
