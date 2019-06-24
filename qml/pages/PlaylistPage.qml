import QtQuick 2.6
import Sailfish.Silica 1.0
import QtMultimedia 5.6

Page {
    property var metaBySource: new Object

    Audio {
        id: audioPlayer
        autoLoad: false
        playlist: playlist
    }
    Playlist { id: playlist }
    SilicaListView {
        id: playlistView
        anchors { fill: parent; bottomMargin: buttonsRow.height }
        header: PageHeader { title: qsTr("Playlist") }
        model: playlist
        delegate: ListItem {

            // ToDo: add menu to remove item

            onClicked: {
                if(playlist.currentIndex === model.index) {
                    if(audioPlayer.playbackState == Audio.PlayingState) {
                        audioPlayer.pause();
                    } else {
                        audioPlayer.play();
                    }
                } else {
                    playlist.currentIndex = model.index;
                    audioPlayer.play();
                }

            }

            menu: ContextMenu {
                MenuItem {
                   text: qsTr("Delete")
                   onClicked: playlist.removeItem(model.index)
                }
            }

            // ToDo: make current on clicked

            Label {
                // ToDo: show title but not the url
                text: metaBySource[source].title
                // ToDo: highlight current track with bold font
                font.bold: model.index === playlist.currentIndex

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    right: parent.right
                    margins: Theme.horizontalPageMargin
                }
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
            }
        }

        PullDownMenu {
            quickSelect: true

            MenuItem {
                text: qsTr("Select music")
                onClicked: {
                    var musicPicker = pageStack.push("Sailfish.Pickers.MultiMusicPickerDialog");
                    musicPicker.accepted.connect(function () {
                        playlist.clear();
                        metaBySource = new Object;
                        for (var iSelectedItem = 0; iSelectedItem < musicPicker.selectedContent.count; ++iSelectedItem) {
                            var selectedItem = musicPicker.selectedContent.get(iSelectedItem);
                            metaBySource[selectedItem.url] = {
                                // ToDo: store content properties

                                fileName: selectedItem.fileName,
                                filePath: selectedItem.silePath,
                                url: selectedItem.url,
                                title: selectedItem.title,
                                mimeTtpe: selectedItem.mimeType
                            }
                            // ToDo: add url to playlist
                            playlist.addItem(selectedItem.url)
                        }
                        // ToDo: start playing
                        audioPlayer.play();
                    });
                    musicPicker.rejected.connect(function () {
                        playlist.clear()
                    });
                }
            }
        }
    }
    Row {
        id: buttonsRow
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: Theme.paddingLarge
        }
        spacing: Theme.paddingLarge

        // ToDo: add buttons for shuffle playlist, move to previous and next tracks

        IconButton {
            icon.source: "image://theme/icon-m-previous"
            onClicked: {
                playlist.previous()
                audioPlayer.play()
            }
        }
        IconButton {
            icon.source: "image://theme/icon-m-shuffle"
            onClicked: {
                playlist.shuffle()
                audioPlayer.play()
            }
        }
        IconButton {
            icon.source: "image://theme/icon-m-next"
            onClicked: {
                playlist.next()
                audioPlayer.play()
            }
        }
    }
}
