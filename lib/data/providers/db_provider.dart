import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/data/models/news.dart';
import '/core/utils/constants.dart';

class DBProvider {

  // Private Constructor
  DBProvider._();
  static DBProvider dbProvider = DBProvider._();

  // Object from database
  Database? database;

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
    String path = join(databasesPath, DATABASE_NAME);
    Database database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  // Create the tables, the columns and the rows
  void _onCreate(db, version) {
    db.execute(
      '''CREATE TABLE $TABLE_NAME (
        $ARTICLE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $ARTICLE_TITLE TEXT NOT NULL,
        $ARTICLE_DATE TEXT NOT NULL,
        $ARTICLE_IMAGE TEXT NOT NULL,
        $ARTICLE_URL TEXT NOT NULL
      )'''
    );
  }

  // Get all favorites articles from the database
  Future<List<News>?>? getArticles() async {
    database = await initDatabase();
    // this will return the articles as a "Map"
    List<Map<String, dynamic>> result = await database!.query(TABLE_NAME);
    List<News> newsList = <News>[];
    result.forEach((news) {
      // convert the "Map" to "News" and add the news to "newsList"
      newsList.add(News.fromJson(news));
    });
    return newsList;
  }

  // Insert new article in the database
  Future<void> insertNews(News news) async {
    try {
      database = await initDatabase();
      await database!.insert(TABLE_NAME, news.toJson());
    } on Exception catch (e) {
      print(e);
    }
  }

  // Delete article from the database
  Future<void> deleteNews(News news) async {
    try {
      database = await initDatabase();
      await database!.delete(TABLE_NAME, where: '$ARTICLE_ID=?', whereArgs: [news.id]);
    } on Exception catch (e) {
      print(e);
    }
  }

}