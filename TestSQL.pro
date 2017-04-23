# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = TestSQL

CONFIG += sailfishapp

SOURCES += src/TestSQL.cpp \
    sqlparser.cpp

OTHER_FILES += qml/TestSQL.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/TestSQL.changes.in \
    rpm/TestSQL.spec \
    rpm/TestSQL.yaml \
    translations/*.ts \
    TestSQL.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/TestSQL-de.ts

DISTFILES += \
    qml/model/TestListModel.qml \
    qml/secvice/Dao.qml \
    icons/108x108/TestSQL.png \
    icons/128x128/TestSQL.png \
    icons/256x256/TestSQL.png \
    icons/86x86/TestSQL.png \
    qml/service/Dao.qml

HEADERS += \
    sqlparser.h

INCLUDEPATH += /usr/include/c++/6.3.1/
LIBS += -lsqlite3
