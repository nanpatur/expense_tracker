// the code below is used to create a class database for creating the sqlite database
// for our project
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  // the code below is used to create a static final instance of the Database provider class
  static final DatabaseProvider dbProvider = DatabaseProvider();

  // the code below is used to create an instance of the database from our sqflite package
  Database? database;

  // the code below is used to create a getter for checking that if the database
  // is not null then returning the database else creating a new database
  Future<Database> get db async {
    if (database != null) {
      return database!;
    } else {
      database = await createDatabase();
      return database!;
    }
  }

  // the code below is used to create a method to create the database
  Future<Database> createDatabase() async {
    // the code below is used to get the location of the application document directory
    Directory docDirectory = await getApplicationDocumentsDirectory();
    // the code below is useed to get the path where our sqlite database will be located
    // by using the join method
    String path =
        join(docDirectory.path, "myExpenseDatabase.db"); // here myExpenseDatabase.db is the name of
    // our database

    // in the line of code below we need to use the openDatabase() method to
    // open the database and create the table using raw sql command
    var database = await openDatabase(
      path, // the path where our database is located
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE expenseTable ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
            "description TEXT, "
            "amount INTEGER, "
            "date TEXT, "
            "category INTEGER "
            ")");
      },

         
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        if (newVersion > oldVersion) {}
      },
    );

    return database;
  }
}
