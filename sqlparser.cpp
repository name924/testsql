#include "sqlparser.h"


static int callback(void *NotUsed, int argc, char **argv, char **azColName){
   int i;
   for(i=0; i<argc; i++){
      printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
   }
   printf("\n");
   return 0;
}

SQLParser::SQLParser()
{
    /*
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));
    QFile file("data");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return;

    QTextStream in(&file);
    in.setCodec("UTF-8");
    while (!in.atEnd()) {
        QString line = in.readLine();
        qDebug() << line;
    }
    */
    qDebug() << "Hi!";
    start_parse();
}

void SQLParser::start_parse()
{
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));

    int i = 0;
    std::string inf = "";
    dicfile.open("data");
    std::string line;

    std::getline(dicfile, line);
    int s = line.find(">") + 1;
    int e = line.find("<", s);
    qDebug() << QString::fromStdString(line.substr(s, e - s));
    dic_data.push_back(Dic_data(line.substr(s, e - s)));

    while (std::getline(dicfile, line))
    {
        //qDebug() << QString::fromStdString(line);
        if (line.find("<k>") != -1){
            s = line.find(">") + 1;
            e = line.find("<", s);
            inf += line.substr(0, line.find("<"));
            //qDebug() << "inf: " << QString::fromStdString(inf);
            dic_data[i].set_info(inf);
            inf = "";
            i += 1;
            dic_data.push_back(Dic_data(line.substr(s, e - s)));
            //qDebug() << QString::fromStdString(line.substr(s, e - s));
        }
        else{
            inf += line + '\n';
        }
    }

    qDebug() << get_item_info();

    ///////////////////////////////////////////////////
    sqlite3 *db;
    char *zErrMsg = 0;
    int rc;
    char *sql;

    /* Open database */
    rc = sqlite3_open("/home/nemo/.local/share/TestSQL/TestSQL/QML/OfflineStorage/Databases/a708e8b63b170c5319af5a6423c8c44f.sqlite", &db);
    if( rc ){
        //fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        qDebug() << "Can't open database: " + QString::fromStdString(sqlite3_errmsg(db));
        return;
    }else{
        //fprintf(stderr, "Opened database successfully\n");
        qDebug() << "Opened database successfully";
    }
/*
    sql = "CREATE TABLE CppTable2("  \
          "ID INTEGER PRIMARY KEY AUTOINCREMENT," \
          "NAME           TEXT    NOT NULL);";

    rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
    if( rc != SQLITE_OK ){
        //fprintf(stderr, "SQL error: %s\n", zErrMsg);
        qDebug() << "SQL error: " + QString::fromStdString(zErrMsg);
        sqlite3_free(zErrMsg);
    }else{
        //fprintf(stdout, "Table created successfully\n");
        qDebug() << "Table created successfully";
    }
*/

    sql = "INSERT INTO TestTable (datatxt) "  \
          "VALUES ('c++ string'); ";

     /* Execute SQL statement */
    rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
    if( rc != SQLITE_OK ){
        //fprintf(stderr, "SQL error: %s\n", zErrMsg);
        qDebug() << "SQL error: " + QString::fromStdString(zErrMsg);
        sqlite3_free(zErrMsg);
    }else{
        //fprintf(stdout, "Records created successfully\n");
        qDebug() << "Records created successfully";
    }
    sqlite3_close(db);
}

QString SQLParser::get_item_info(){
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));
    return QString::fromStdString(dic_data.at(1).get_word()) + " " + QString::fromStdString(dic_data.at(0).get_info());
}
