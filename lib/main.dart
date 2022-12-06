import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home.dart';
import 'onboarding_inapp_webview.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  await Permission.camera.request();
  await Permission.microphone.request();

  runApp(const AppMain());
}

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (_) => const HomeScreen(title: "WebView Flutter"),
        "/inapp": (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map;
          return OnboardingInAppWebview(url: args["url"]);
        },
      },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: InAppWebViewPage());
  }
}

class InAppWebViewPage extends StatefulWidget {
  const InAppWebViewPage({super.key});

  @override
  InAppWebViewPageState createState() => InAppWebViewPageState();
}

class InAppWebViewPageState extends State<InAppWebViewPage> {
  InAppWebViewController? _webViewController;
  final initalUrl = URLRequest(
      url: Uri.parse(
          "https://app-dev.certfy.tech/onboarding/autoid/c873938a-7c34-43a8-9218-66f6b45e3066/steps"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("InAppWebView")),
        body: Column(children: <Widget>[
          Expanded(
            child: InAppWebView(
              // initialUrlRequest: initalUrl,
              // initialOptions: InAppWebViewGroupOptions(
              //   crossPlatform: InAppWebViewOptions(
              //     mediaPlaybackRequiresUserGesture: false,
              //   ),
              // ),
              onWebViewCreated: (InAppWebViewController controller) async {
                _webViewController = controller;
                if (!Platform.isAndroid ||
                    await AndroidWebViewFeature.isFeatureSupported(
                        AndroidWebViewFeature.WEB_MESSAGE_LISTENER)) {
                  await controller.addWebMessageListener(WebMessageListener(
                    jsObjectName: "flutterWebview",
                    onPostMessage:
                        (message, sourceOrigin, isMainFrame, replyProxy) {
                      // do something about message, sourceOrigin and isMainFrame.
                      print(message);
                      // replyProxy.postMessage("Got it!");
                    },
                  ));
                }

                _webViewController?.loadUrl(urlRequest: initalUrl);
              },
              androidOnPermissionRequest: (InAppWebViewController controller,
                  String origin, List<String> resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              onLoadStop: (controller, url) async {
                await controller.evaluateJavascript(source: """
                        window.isFlutterWebView = true;
                      """);
              },
            ),
          ),
        ]));
  }
}
