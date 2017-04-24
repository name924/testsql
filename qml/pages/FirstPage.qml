/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
//import com.saildev.components 1.0

import "../service"
import "../model"

Page {
    id: page

//    SQLParser {
//        id: sql_parser
//    }

    Label {
        id: ifNoEntries
        color: Theme.secondaryHighlightColor
        y: page.height / 2
        anchors.horizontalCenter: parent.horizontalCenter
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        PageHeader {
            id: header
            title: "Test entries"
            width: parent.width
        }
        Column {
            id: column
            width: parent.width
            anchors.top: header.bottom
            spacing: Theme.paddingLarge

            Label {
                id: label
                text: "List of all entries:"
                x: Theme.paddingLarge
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
            }
/*
            Label {
                id: label2
                text: qsTr(sql_parser.get_item_info())
                x: Theme.paddingLarge
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
            }
*/
            SilicaListView {
                id: listView
                model: EntryListModel { id: testListModel }
                width: parent.width
                VerticalScrollDecorator {}
                height: parent.height
                clip: true
                delegate: ListItem {
                    Label {
                        id: enrtyID
                        text: id
                        truncationMode: TruncationMode.Fade
                        anchors.left: parent.left
                        anchors.leftMargin: Theme.paddingLarge
                        anchors.right: parent.right
                    }
                    Label {
                        id: dataLabel
                        text: datatxt
                        anchors.right: parent.right
                        anchors.rightMargin: Theme.paddingLarge
                    }
                }
                Component.onCompleted: displayTestEntries()
            }
        }
    }

    function displayTestEntries() {
        testListModel.clear();
        dao.retrieveTextEntries(function(testEntries) {
            ifNoEntries.text = "";
            if(testEntries.length !== 0) {
                for (var i = 0; i < testEntries.length; i++) {
                    var testEntry = testEntries.item(i);

                    testListModel.addDictEntry(testEntry.word, testEntry.dict);
                }
            } else {
                ifNoEntries.text = "You don't have any actual entries right now";
            }
        });
    }
}
