import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        name: 'gtm_mobile_sample_app',
        options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Initialize Firebase Analytics
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // Initialize Firebase Analytics Observer
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Firebase Analytics Demo',
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = '';

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  // GA4 related functions
  Future<void> _sendAnalyticsEvent() async {
    // Only strings and numbers (longs & doubles for android, ints and doubles for iOS) are supported for GA custom event parameters:
    // https://firebase.google.com/docs/reference/ios/firebaseanalytics/api/reference/Classes/FIRAnalytics#+logeventwithname:parameters:
    // https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics#public-void-logevent-string-name,-bundle-params
    await widget.analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/custom-dims-mets#overview
        'bool': true.toString(),
      },
    );

    setMessage('logEvent succeeded');
  }

  Future<void> _testSetUserId() async {
    await widget.analytics.setUserId(id: 'some-user');
    setMessage('setUserId succeeded');
  }

  Future<void> _testSetUserProperty() async {
    await widget.analytics.setUserProperty(name: 'regular', value: 'indeed');
    setMessage('setUserProperty succeeded');
  }

  // Can set parameters for the event for dynamic case
  // Create variables in the GTM container
  // GTM related functions
  Future<void> _addGTMEvent() async {
    await widget.analytics.logEvent(
      name: 'test_adding_event',
    );

    setMessage('Added GTM Event');
  }

  Future<void> _modifyGTMEvent() async {
    await widget.analytics.logEvent(
      name: 'test_modify_event',
    );

    setMessage('Modified GTM Event, changed event name to Modified_Event');
  }

  Future<void> _blockGTMEvent() async {
    await widget.analytics.logEvent(
      name: 'test_block_event',
    );

    setMessage('Blocked GTM Event. This event would not be sent to GA4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: _sendAnalyticsEvent,
              child: const Text('Test logEvent'),
            ),
            MaterialButton(
              onPressed: _testSetUserId,
              child: const Text('Test setUserId'),
            ),
            MaterialButton(
              onPressed: _testSetUserProperty,
              child: const Text('Test setUserProperty'),
            ),
            MaterialButton(
              onPressed: _addGTMEvent,
              child: const Text('Test GTM Add event'),
            ),
            MaterialButton(
              onPressed: _modifyGTMEvent,
              child: const Text('Test GTM Modify event'),
            ),
            MaterialButton(
              onPressed: _blockGTMEvent,
              child: const Text('Test GTM Block event'),
            ),
            Text(
              _message,
              style: const TextStyle(color: Color.fromARGB(255, 0, 155, 0)),
            ),
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
