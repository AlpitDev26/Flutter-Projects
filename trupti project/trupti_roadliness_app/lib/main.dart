// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'models/client.dart';
// import 'models/invoice.dart';
// import 'models/InvoiceItems.dart';
// import 'services/database_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await insertSampleData(); // optional: load once
//   runApp(const MyApp());
// }

// Future<void> insertSampleData() async {
//   final db = DatabaseService();

//   Client client = Client(
//     name: 'Aryamman Interior Solutions Pvt Ltd',
//     address: 'Pravasi Industrial Estate, Goregaon, Mumbai',
//     email: 'client@example.com',
//     phone: '9920824263',
//   );

//   await db.insertClient(client);

//   Invoice invoice = Invoice(
//     invoiceNo: 'TR/1133',
//     invoiceDate: '2025-04-24',
//     client: client,
//     items: [
//       InvoiceItem(
//         particulars: 'SARIGAM VAPI TO BHIWANDI',
//         vehicleNo: 'MH48 G 2260',
//         pkg: '330/3300 KGS',
//         amount: 9000,
//       ),
//       InvoiceItem(
//         particulars: 'UNLOAD CHARGE',
//         vehicleNo: '',
//         pkg: '',
//         amount: 500,
//       ),
//     ],
//     totalAmount: 9500,
//     amountInWords: 'Nine Thousand Five Hundred Only',
//     bankDetails: 'Bank of Maharashtra, AJC No. 20018403-490, IFSC: MAHB0000183',
//     paymentNote: 'Service tax payable by consignor/consignee',
//   );

//   await db.insertInvoice(invoice);
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Transport Billing App Initialized'),
//         ),
//       ),
//     );
//   }
// }












// lib/main.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'models/client.dart';
import 'models/invoice.dart';
import 'models/InvoiceItems.dart';
import 'services/database_service.dart';
import 'screens/home_screen.dart';
import 'screens/invoice_detail_screen.dart';
import 'screens/create_edit_invoice_screen.dart';
import 'screens/client_list_screen.dart';
import 'screens/create_edit_client_screen.dart';
import 'screens/business_profile_screen.dart';
import 'models/BusinessProfile.dart'; // Import BusinessProfile model

void main() async {
  // Ensure Flutter widgets are initialized before database operations.
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the database service.
  final db = DatabaseService();
  await db.initDatabase();

  // Insert sample data if the database is empty for demonstration.
  await insertSampleData(db);

  runApp(const MyApp());
}

// Function to insert sample data into the database.
Future<void> insertSampleData(DatabaseService db) async {
  // Check if there are any clients or invoices to avoid re-inserting data on every app start.
  final clients = await db.getClients();
  final invoices = await db.getInvoices();
  final businessProfiles = await db.getBusinessProfile();

  if (clients.isEmpty && invoices.isEmpty) {
    // Create a sample client.
    Client client = Client(
      name: 'Aryamman Interior Solutions Pvt Ltd',
      address: 'Pravasi Industrial Estate, Goregaon, Mumbai',
      email: 'client@example.com',
      phone: '9920824263',
    );
    await db.insertClient(client);

    // Create a sample invoice.
    Invoice invoice = Invoice(
      invoiceNo: 'TR/1133',
      invoiceDate: DateFormat('yyyy-MM-dd').format(DateTime.now()), // Current date
      client: client,
      items: [
        InvoiceItem(
          particulars: 'SARIGAM VAPI TO BHIWANDI',
          vehicleNo: 'MH48 G 2260',
          pkg: '330/3300 KGS',
          amount: 9000,
        ),
        InvoiceItem(
          particulars: 'UNLOAD CHARGE',
          vehicleNo: '',
          pkg: '',
          amount: 500,
        ),
      ],
      totalAmount: 9500,
      amountInWords: 'Nine Thousand Five Hundred Only',
      bankDetails: 'Bank of Maharashtra, AJC No. 20018403-490, IFSC: MAHB0000183',
      paymentNote: 'Payment due within 30 days.', id: null,
    );
    await db.insertInvoice(invoice);
    print('Sample client and invoice inserted.');
  }

  if (businessProfiles == null) {
    // Insert a default business profile if none exists.
    BusinessProfile defaultProfile = BusinessProfile(
      companyName: 'Your Company Name',
      address: 'Your Company Address, City, State, Pincode',
      email: 'your.email@example.com',
      phone: '9876543210',
      pan: 'ABCDE1234F',
      gst: '27ABCDE1234F1Z5',
      bankName: 'Your Bank Name',
      accountNo: '1234567890',
      ifsc: 'BANK0000123',
    );
    await db.insertBusinessProfile(defaultProfile);
    print('Default business profile inserted.');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Billing Invoice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          buttonColor: Colors.blueAccent,
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ),
      // Define named routes for navigation.
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/invoice_detail': (context) => const InvoiceDetailScreen(),
        '/create_edit_invoice': (context) => const CreateEditInvoiceScreen(),
        '/client_list': (context) => const ClientListScreen(),
        '/create_edit_client': (context) => const CreateEditClientScreen(),
        '/business_profile': (context) => const BusinessProfileScreen(),
      },
      // OnGenerateRoute is used for passing arguments to routes.
      onGenerateRoute: (settings) {
        if (settings.name == '/invoice_detail') {
          final invoiceId = settings.arguments as int?;
          return MaterialPageRoute(
            builder: (context) {
              return InvoiceDetailScreen(invoiceNo: invoiceId);
            },
          );
        } else if (settings.name == '/create_edit_invoice') {
          final invoiceId = settings.arguments as int?;
          return MaterialPageRoute(
            builder: (context) {
              return CreateEditInvoiceScreen(invoiceId: invoiceId);
            },
          );
        } else if (settings.name == '/create_edit_client') {
          final clientId = settings.arguments as int?;
          return MaterialPageRoute(
            builder: (context) {
              return CreateEditClientScreen(clientId: clientId);
            },
          );
        }
        return null; // Let `routes` handle other paths.
      },
    );
  }
}
