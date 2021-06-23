import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/news.dart';

class DBHelper {

  // Private Constructor
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();

  // Object from database
  Database? database;

  final databaseName = 'newsDB.db';
  static String tableName = 'articles';
  static String articleId = 'id';
  static String articleTitle = 'title';
  static String articleDate = 'publishedAt';
  static String articleImage = 'urlToImage';
  static String articleUrl = 'url';

  // Initialize the database
  Future<Database?>? initDatabase() async {
    if (database == null)
    {
      return await createDatabase();
    } else {
      return database!;
    }
  }

  // Create the database
  Future<Database?>? createDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);
    Database database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  // Create the tables, the columns and the rows
  void _onCreate(db, version) {
    db.execute(
      '''CREATE TABLE $tableName (
        $articleId INTEGER PRIMARY KEY AUTOINCREMENT,
        $articleTitle TEXT NOT NULL,
        $articleDate TEXT NOT NULL,
        $articleImage TEXT NOT NULL,
        $articleUrl TEXT NOT NULL
      )'''
    );
  }

  // Get all favorites articles from the database
  Future<List<News>?>? getArticles() async {
    database = await initDatabase();
    // this will return the articles as a "Map"
    List<Map<String, dynamic>> result = await database!.query(tableName);
    List<News> newsList = <News>[];
    result.forEach((news) {
      // convert the "Map" to "News" and add the news to "newsList"
      newsList.add(News.fromJson(news));
    });
    return newsList;
  }

  // Insert new article in the database
  insertNews(News news) async {
    try {
      database = await initDatabase();
      await database!.insert(tableName, news.toJson());
    } on Exception catch (e) {
      print(e);
    }
  }

  // Delete article from the database
  deleteNews(News news) async {
    try {
      database = await initDatabase();
      await database!.delete(tableName, where: '$articleId=?', whereArgs: [news.id]);
    } on Exception catch (e) {
      print(e);
    }
  }

}
