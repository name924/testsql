import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    property var database

    Component.onCompleted: {
        database = LocalStorage.openDatabaseSync("MyTestDatabase2", "1.0")
        database.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS TestTable(
                 id INTEGER PRIMARY KEY AUTOINCREMENT,
                 datatxt TEXT)");

            var result = tx.executeSql("SELECT COUNT(*) as count FROM TestTable").rows.item(0).count;
            if (result === 0) {
                console.log("Adding items to new database...")
                tx.executeSql("INSERT INTO TestTable(datatxt) VALUES(?)",
                              [qsTr("Test string 1")]);
                tx.executeSql("INSERT INTO TestTable(datatxt) VALUES(?)",
                              [qsTr("Test string 2")]);
                console.log("Done!")
            }
        });
    }

    function retrieveTextEntries(callback) {
        database = LocalStorage.openDatabaseSync("MyTestDatabase2", "1.0");
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM TestTable");
            callback(result.rows)
        });
    }

}

