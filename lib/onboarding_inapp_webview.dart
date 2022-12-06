import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class OnboardingInAppWebview extends StatefulWidget {
  final String url;

  const OnboardingInAppWebview({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<OnboardingInAppWebview> createState() => _OnboardingWebviewState();
}

class _OnboardingWebviewState extends State<OnboardingInAppWebview> {
  bool loadingPage = false;
  // final Completer _controller = Completer<WebViewController>();

  final GlobalKey keyApp = GlobalKey();
  InAppWebViewController? _inAppController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      mediaPlaybackRequiresUserGesture: false,
    ),
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(children: [
          InAppWebView(
              key: keyApp,
              // initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
              initialOptions: options,
              onWebViewCreated: (controller) async {
                _inAppController = controller;

                if (!Platform.isAndroid ||
                    await AndroidWebViewFeature.isFeatureSupported(
                        AndroidWebViewFeature.WEB_MESSAGE_LISTENER)) {
                  await controller.addWebMessageListener(WebMessageListener(
                    jsObjectName: "actionToFinish",
                    onPostMessage:
                        (message, sourceOrigin, isMainFrame, replyProxy) {
                      if (message != null) {
                        Navigator.of(context).pop();
                      }
                    },
                  ));
                }

                await _inAppController!.loadUrl(
                    urlRequest: URLRequest(url: Uri.parse(widget.url)));
                // }
              },
              onLoadStart: (controller, url) {
                if (_inAppController != null) {
                  _inAppController!.evaluateJavascript(source: '''
                    window.isFlutterWebView = true;
                  ''');
                }
              },
              androidOnPermissionRequest: (InAppWebViewController controller,
                  String origin, List<String> resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              }),
          if (loadingPage) const LinearProgressIndicator()
        ]),
      ),
    );
  }
}
