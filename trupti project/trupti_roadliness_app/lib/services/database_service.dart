// import 'dart:convert';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import '../models/client.dart';
// import '../models/invoice.dart';
// import '../models/businessProfile.dart';

// class DatabaseService {
//   static final DatabaseService _instance = DatabaseService._internal();
//   factory DatabaseService() => _instance;
//   DatabaseService._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     return _database ??= await _initDatabase();
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'billing.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE clients (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         address TEXT,
//         email TEXT,
//         phone TEXT
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE invoices (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         invoiceNo TEXT,
//         invoiceDate TEXT,
//         client TEXT,         -- JSON encoded Client
//         items TEXT,          -- JSON encoded list of InvoiceItems
//         totalAmount REAL,
//         amountInWords TEXT,
//         bankDetails TEXT,
//         paymentNote TEXT
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE business_profile (
//         id INTEGER PRIMARY KEY,
//         companyName TEXT,
//         address TEXT,
//         email TEXT,
//         phone TEXT,
//         pan TEXT,
//         gst TEXT,
//         bankName TEXT,
//         accountNo TEXT,
//         ifsc TEXT
//       )
//     ''');
//   }

//   // ---------------- CLIENTS ----------------

//   Future<int> insertClient(Client client) async {
//     final db = await database;
//     return await db.insert('clients', client.toMap());
//   }

//   Future<List<Client>> getClients() async {
//     final db = await database;
//     final result = await db.query('clients');
//     return result.map((e) => Client.fromMap(e)).toList();
//   }

//   // ---------------- INVOICES ----------------

//   Future<int> insertInvoice(Invoice invoice) async {
//     final db = await database;
//     return await db.insert('invoices', {
//       'invoiceNo': invoice.invoiceNo,
//       'invoiceDate': invoice.invoiceDate,
//       'client': jsonEncode(invoice.client.toMap()),
//       'items': jsonEncode(invoice.items.map((e) => e.toMap()).toList()),
//       'totalAmount': invoice.totalAmount,
//       'amountInWords': invoice.amountInWords,
//       'bankDetails': invoice.bankDetails,
//       'paymentNote': invoice.paymentNote,
//     });
//   }

//   Future<List<Invoice>> getInvoices() async {
//     final db = await database;
//     final result = await db.query('invoices');
//     return result.map((e) => Invoice.fromMap({
//       'id': e['id'],
//       'invoiceNo': e['invoiceNo'],
//       'invoiceDate': e['invoiceDate'],
//       'client': jsonDecode(e['client'] as String),
//       'items': jsonDecode(e['items'] as String),
//       'totalAmount': e['totalAmount'],
//       'amountInWords': e['amountInWords'],
//       'bankDetails': e['bankDetails'],
//       'paymentNote': e['paymentNote'],
//     })).toList();
//   }

//   // ---------------- BUSINESS PROFILE ----------------

//   Future<void> saveBusinessProfile(BusinessProfile profile) async {
//     final db = await database;
//     await db.insert('business_profile', profile.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<BusinessProfile?> getBusinessProfile() async {
//     final db = await database;
//     final result = await db.query('business_profile', limit: 1);
//     if (result.isEmpty) return null;
//     return BusinessProfile.fromMap(result.first);
//   }
// }






// lib/services/database_service.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trupti_roadliness_app/models/BusinessProfile.dart';
import 'package:trupti_roadliness_app/models/InvoiceItems.dart';
import '../models/client.dart';
import '../models/invoice.dart';
// Import BusinessProfile model
import 'dart:convert'; // For JSON encoding/decoding of InvoiceItem list

class DatabaseService {
  static Database? _database;
  static const String _databaseName = 'billing_app.db';
  static const int _databaseVersion = 1;

  // Table names
  static const String _clientsTable = 'clients';
  static const String _invoicesTable = 'invoices';
  static const String _businessProfileTable = 'business_profile';

  // Private constructor to prevent direct instantiation.
  DatabaseService._privateConstructor();
  // Singleton instance.
  static final DatabaseService _instance = DatabaseService._privateConstructor();

  // Factory constructor to return the singleton instance.
  factory DatabaseService() {
    return _instance;
  }

  // Getter for the database instance.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initializes the database.
  Future<Database> _initDatabase() async {
    // Get the default database location for the platform.
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Called when the database is created for the first time.
  Future<void> _onCreate(Database db, int version) async {
    // Create clients table.
    await db.execute('''
      CREATE TABLE $_clientsTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL
      )
    ''');

    // Create invoices table.
    // client_id will be a foreign key, but we'll store client details directly as JSON
    // for simplicity in this example, or fetch by ID if needed.
    // For invoice items, we'll store them as a JSON string.
    await db.execute('''
      CREATE TABLE $_invoicesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoiceNo TEXT NOT NULL,
        invoiceDate TEXT NOT NULL,
        clientId INTEGER NOT NULL, -- Store client ID
        clientName TEXT NOT NULL, -- Store client name for easy display
        clientAddress TEXT NOT NULL,
        clientEmail TEXT NOT NULL,
        clientPhone TEXT NOT NULL,
        items TEXT NOT NULL, -- Store List<InvoiceItem> as JSON string
        totalAmount REAL NOT NULL,
        amountInWords TEXT NOT NULL,
        bankDetails TEXT NOT NULL,
        paymentNote TEXT NOT NULL
      )
    ''');

    // Create business profile table.
    await db.execute('''
      CREATE TABLE $_businessProfileTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        companyName TEXT NOT NULL,
        address TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL,
        pan TEXT NOT NULL,
        gst TEXT NOT NULL,
        bankName TEXT NOT NULL,
        accountNo TEXT NOT NULL,
        ifsc TEXT NOT NULL
      )
    ''');
  }

  // Called when the database needs to be upgraded.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database schema migrations here if your version changes.
    // For now, we'll just drop and recreate tables for simplicity in development.
    // In a real app, you'd use ALTER TABLE statements.
    if (oldVersion < newVersion) {
      await db.execute('DROP TABLE IF EXISTS $_clientsTable');
      await db.execute('DROP TABLE IF EXISTS $_invoicesTable');
      await db.execute('DROP TABLE IF EXISTS $_businessProfileTable');
      await _onCreate(db, newVersion);
    }
  }

  // --- Client Operations ---
  Future<int> insertClient(Client client) async {
    final db = await database;
    return await db.insert(_clientsTable, client.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Client>> getClients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_clientsTable);
    return List.generate(maps.length, (i) => Client.fromMap(maps[i]));
  }

  Future<Client?> getClientById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _clientsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Client.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateClient(Client client) async {
    final db = await database;
    return await db.update(
      _clientsTable,
      client.toMap(),
      where: 'id = ?',
      whereArgs: [client.id],
    );
  }

  Future<int> deleteClient(int id) async {
    final db = await database;
    return await db.delete(
      _clientsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Invoice Operations ---
  Future<int> insertInvoice(Invoice invoice) async {
    final db = await database;
    // Prepare invoice data for insertion.
    Map<String, dynamic> invoiceMap = invoice.toMap();
    // Store client ID and details separately for easier querying later.
    invoiceMap['clientId'] = invoice.client.id;
    invoiceMap['clientName'] = invoice.client.name;
    invoiceMap['clientAddress'] = invoice.client.address;
    invoiceMap['clientEmail'] = invoice.client.email;
    invoiceMap['clientPhone'] = invoice.client.phone;

    // Convert List<InvoiceItem> to JSON string.
    invoiceMap['items'] = jsonEncode(invoice.items.map((item) => item.toMap()).toList());

    // Remove client object and original items list from the map before inserting.
    invoiceMap.remove('client');
    // Ensure 'id' is not included if it's null for auto-increment.
    if (invoiceMap['id'] == null) {
      invoiceMap.remove('id');
    }


    return await db.insert(_invoicesTable, invoiceMap,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Invoice>> getInvoices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_invoicesTable, orderBy: 'id DESC'); // Order by ID descending for newest first
    return List.generate(maps.length, (i) {
      // Reconstruct Client object from stored client details.
      Client client = Client(
        id: maps[i]['clientId'],
        name: maps[i]['clientName'],
        address: maps[i]['clientAddress'],
        email: maps[i]['clientEmail'],
        phone: maps[i]['clientPhone'],
      );
      // Decode JSON string back to List<InvoiceItem>.
      List<InvoiceItem> items = (jsonDecode(maps[i]['items']) as List)
          .map((itemMap) => InvoiceItem.fromMap(itemMap))
          .toList();

      return Invoice(
        id: maps[i]['id'],
        invoiceNo: maps[i]['invoiceNo'],
        invoiceDate: maps[i]['invoiceDate'],
        client: client,
        items: items,
        totalAmount: maps[i]['totalAmount'],
        amountInWords: maps[i]['amountInWords'],
        bankDetails: maps[i]['bankDetails'],
        paymentNote: maps[i]['paymentNote'],
      );
    });
  }

  Future<Invoice?> getInvoiceById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _invoicesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      // Reconstruct Client object.
      Client client = Client(
        id: maps.first['clientId'],
        name: maps.first['clientName'],
        address: maps.first['clientAddress'],
        email: maps.first['clientEmail'],
        phone: maps.first['clientPhone'],
      );
      // Decode JSON string back to List<InvoiceItem>.
      List<InvoiceItem> items = (jsonDecode(maps.first['items']) as List)
          .map((itemMap) => InvoiceItem.fromMap(itemMap))
          .toList();

      return Invoice(
        id: maps.first['id'],
        invoiceNo: maps.first['invoiceNo'],
        invoiceDate: maps.first['invoiceDate'],
        client: client,
        items: items,
        totalAmount: maps.first['totalAmount'],
        amountInWords: maps.first['amountInWords'],
        bankDetails: maps.first['bankDetails'],
        paymentNote: maps.first['paymentNote'],
      );
    }
    return null;
  }

  Future<int> updateInvoice(Invoice invoice) async {
    final db = await database;
    Map<String, dynamic> invoiceMap = invoice.toMap();
    // Prepare invoice data for update.
    invoiceMap['clientId'] = invoice.client.id;
    invoiceMap['clientName'] = invoice.client.name;
    invoiceMap['clientAddress'] = invoice.client.address;
    invoiceMap['clientEmail'] = invoice.client.email;
    invoiceMap['clientPhone'] = invoice.client.phone;
    invoiceMap['items'] = jsonEncode(invoice.items.map((item) => item.toMap()).toList());

    invoiceMap.remove('client');
    invoiceMap.remove('id'); // ID is used in where clause, not in update map itself.

    return await db.update(
      _invoicesTable,
      invoiceMap,
      where: 'id = ?',
      whereArgs: [invoice.invoiceNo],
    );
  }

  Future<int> deleteInvoice(int id) async {
    final db = await database;
    return await db.delete(
      _invoicesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Business Profile Operations ---
  Future<int> insertBusinessProfile(BusinessProfile profile) async {
    final db = await database;
    // Always replace the existing profile (there should only be one).
    return await db.insert(_businessProfileTable, profile.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<BusinessProfile?> getBusinessProfile() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_businessProfileTable);
    if (maps.isNotEmpty) {
      return BusinessProfile.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateBusinessProfile(BusinessProfile profile) async {
    final db = await database;
    return await db.update(
      _businessProfileTable,
      profile.toMap(),
      where: 'id = ?', // Assuming there's always an ID of 1 for the single profile.
      whereArgs: [1], // Update the first (and only) row.
    );
  }

  initDatabase() {}
}
