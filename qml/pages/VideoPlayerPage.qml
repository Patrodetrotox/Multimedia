import QtQuick 2.6
import Sailfish.Silica 1.0
import QtMultimedia 5.6

Page {
    allowedOrientations: Orientation.All
    // ToDo: pause playback when the page is not active


    onStateChanged: {
        if( status === PageStatus.Active) {

        } else {
            player.pause();
        }
    }

    SilicaFlickable {
        anchors.fill: parent

        Video {
            id: player
            width: parent.width
            height: parent.height
            autoPlay: true
            onPositionChanged: progressSlider.value = position
            // ToDo: change progress slider value when position changed

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    switch(player.playbackState) {
                    case MediaPlayer.PlayingState:
                        player.pause();
                        break;
                    default:
                        player.play();
                        break;
                    }
                }

                // ToDo: play or pause on clicked
            }
        }
        PullDownMenu {
            id: videoSelectMenu
            quickSelect: true

            // ToDo: add item to call video picker
            MenuItem {
                text: qsTr("Open file")
                onClicked: {
                    var videoPicker =
                            pageStack.push("Sailfish.Pickers.VideoPickerPage");
                    videoPicker.selectedContentChanged.connect(function () {
                        player.source = videoPicker.selectedContent;
                        player.play();
                    });



                }
            }
        }
    }

    Slider {
        id: progressSlider
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        minimumValue: 0
        maximumValue: player.duration || 1
        onReleased: player.seek(value)
        valueText: (value / 1000).toFixed(2)

    }

    // ToDo: add silder to control playback
}
