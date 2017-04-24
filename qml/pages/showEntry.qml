import QtQuick 2.2
import Sailfish.Silica 1.0
import "../service"

Page {
    property string dict
    property string entry

    allowedOrientations: defaultAllowedOrientations

//    PageHeader {
//        id: header
//        title: entry
//    }

    function fillModel(){
        translationListModel.clear()
        dao.getTranslations(entry, dict, function(entries) {
            console.log(entry + " was clicked! It has " + entries.length + " translations" );
            if(entries.length !== 0) {
                for (var i = 0; i < entries.length; i++) {
                    var entryI = entries.item(i);

                    translationListModel.addTranslation(entryI.info);
                }
            }
        });
    }

    Component.onCompleted: {
        fillModel()
    }

    SilicaFlickable {
//        anchors {left: parent.left; right: parent.right; top: header.bottom}
//        anchors.topMargin: 15
        anchors.fill: parent
//        contentHeight: column.height

//        Component {
//            id: listViewComponent
        PageHeader {
            id: header
            title: entry
        }
            SilicaListView {
                id: listView
                anchors.fill: parent
                anchors.top: header.bottom
                currentIndex: -1

//                model: translationListModel
                model: ListModel{
                    id: translationListModel
                    function addTranslation(translation) {
                        append({ info: translation });
                    }
                }

                delegate: ListItem {
                    contentHeight: Theme.itemSizeMedium
                    anchors.margins: Theme.paddingMedium

                    Label {
                        id: translation
                        property int minimumPointSize: Theme.fontSizeExtraSmall
                        property int maximumPointSize: Theme.fontSizeExtraLarge
                        property int currentPointSize: Theme.fontSizeMedium
                        text: info
                        anchors {left: parent.left; right: parent.right}
                        anchors.margins: Theme.paddingMedium
                        wrapMode: Text.WordWrap
//                        font.pointSize: translation.currentPointSize
                        color: Theme.primaryColor
                        textFormat: Text.RichText

//                        PinchArea {
//                            anchors.fill: parent
//                            onPinchUpdated: {
//                                var desiredSize = pinch.scale * translation.currentPointSize;
//                                if(desiredSize >= translation.minimumPointSize && desiredSize <= translation.maximumPointSize)
//                                    translation.font.pointSize = desiredSize
//                                else if (desiredSize < translation.minimumPointSize)
//                                    translation.font.pointSize = translation.minimumPointSize
//                                else if (desiredSize > translation.maximumPointSize)
//                                    translation.font.pointSize = translation.maximumPointSize
//                            }
//                            onPinchFinished: {
//                                var desiredSize = pinch.scale * translation.currentPointSize;
//                                if(desiredSize >= translation.minimumPointSize && desiredSize <= translation.maximumPointSize)
//                                    translation.currentPointSize = desiredSize
//                                else if (desiredSize < translation.minimumPointSize)
//                                    translation.currentPointSize = translation.minimumPointSize
//                                else if (desiredSize > translation.maximumPointSize)
//                                    translation.currentPointSize = translation.maximumPointSize

//                                translation.font.pointSize = translation.currentPointSize;
//                            }
//                        }
                    }
                    Rectangle {
                        height: listView.curIndex === translationListModel.count - 1 ? 0 : 1
                        color: 'white'
                        anchors {
                            left: parent.left
                            right: parent.right
                            top: translation.bottom
                        }
                        opacity: 0.2
                        anchors.margins: Theme.paddingMedium
                    }
                }
            }
        }

//        Column {
//            id: column
//            width: parent.width
//            spacing: Theme.paddingSmall

//            PageHeader { title: pageTitleEntry }
//            Label {
//                id: translation
//                property int minimumPointSize: Theme.fontSizeExtraSmall
//                property int maximumPointSize: Theme.fontSizeExtraLarge
//                property int currentPointSize: Theme.fontSizeMedium
//                text: dictTranslatedEntry
//                anchors {left: parent.left; right: parent.right}
//                anchors.margins: Theme.paddingMedium
//                wrapMode: Text.WordWrap
//                font.pointSize: translation.currentPointSize
//                color: Theme.primaryColor
//                textFormat: Text.RichText

//                PinchArea {
//                    anchors.fill: parent
//                    onPinchUpdated: {
//                        var desiredSize = pinch.scale * translation.currentPointSize;
//                        if(desiredSize >= translation.minimumPointSize && desiredSize <= translation.maximumPointSize)
//                            translation.font.pointSize = desiredSize
//                        else if (desiredSize < translation.minimumPointSize)
//                            translation.font.pointSize = translation.minimumPointSize
//                        else if (desiredSize > translation.maximumPointSize)
//                            translation.font.pointSize = translation.maximumPointSize
//                    }
//                    onPinchFinished: {
//                        var desiredSize = pinch.scale * translation.currentPointSize;
//                        if(desiredSize >= translation.minimumPointSize && desiredSize <= translation.maximumPointSize)
//                            translation.currentPointSize = desiredSize
//                        else if (desiredSize < translation.minimumPointSize)
//                            translation.currentPointSize = translation.minimumPointSize
//                        else if (desiredSize > translation.maximumPointSize)
//                            translation.currentPointSize = translation.maximumPointSize

//                        translation.font.pointSize = translation.currentPointSize;
//                    }
//                }
//            }
//        }
//    }
}

