import QtQuick 2.6
import Sailfish.Silica 1.0
import QtMultimedia 5.6
import Multimedia 1.0
import "../assets"

Page {
    property string filePath: StandardPaths.documents + "/" + Qt.application.name + ".wav"

    AudioRecorder {
        id: audioRecorder
        outputLocation: filePath
        onStateChanged: {
            if(state == AudioRecorder.StoppedState) {
                audioPlayer.source = "";
                audioPlayer.source = filePath;
            }


        }
        onDurationChanged: record.value = duration
        // ToDo: handle stop to reload audioPlayer
    }
    Audio {
        id: audioPlayer
        source: filePath
        autoLoad: true
    }
    Column {
        anchors.fill: parent
        spacing: Theme.paddingLarge

        PageHeader { title: qsTr("Dictaphone") }
        ValueDisplay {
            id: recordInfo
            label: qsTr("Recorded duration")
            value: audioRecorder.duration || audioPlayer.duration
            // ToDo: set text property to show recorded duration in seconds
            width: parent.width
        }
        Slider {
            id: playInfo
            label: qsTr("Player position")
            width: parent.width
            minimumValue: 0
            maximumValue: audioPlayer.duration || 1
            valueText: (value / 1000).toFixed(2)
            value: audioPlayer.position
            // ToDo: set value, minimumValue, maximumValue and valueText properties
            enabled: false
            down: true
            handleVisible: false
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

        IconButton {
            icon.source: "image://theme/icon-m-call-recording-on"
            onClicked: {
                audioRecorder.record()
            }
            visible: audioPlayer.playbackState === Audio.StoppedState
                && audioRecorder.state !== AudioRecorder.RecordingState
        }

        IconButton {
            icon.source: "image://theme/icon-m-pause"
            onClicked: {
                audioRecorder.pause()
            }
            visible: audioPlayer.playbackState === Audio.StoppedState
                && audioRecorder.state === AudioRecorder.RecordingState
        }

        IconButton {
            icon.source: "image://theme/icon-m-call-recording-off"
            onClicked: {
                audioRecorder.stop()
            }
            visible: audioPlayer.playbackState === Audio.StoppedState
                && audioRecorder.state !== AudioRecorder.StoppedState
        }

        IconButton {
            icon.source: "image://theme/icon-m-play"
            onClicked: {
                audioPlayer.play()
            }
            visible: audioRecorder.state === AudioRecorder.StoppedState
                && audioPlayer.playbackState !== Audio.PlayingState

        }

        IconButton {
            icon.source: "image://theme/icon-m-pause"
            onClicked: {
                audioPlayer.pause()
            }
            visible: audioRecorder.state === AudioRecorder.StoppedState
                && audioPlayer.playbackState === Audio.PlayingState
        }

        IconButton {
            icon.source: "image://theme/icon-m-clear"
            onClicked: {
                audioPlayer.stop()
            }
            visible: audioRecorder.state === AudioRecorder.StoppedState
                && audioPlayer.playbackState !== Audio.StoppedState
        }

        // ToDo: add button to start recording
        // ToDo: add button to pause recording
        // ToDo: add button to stop recording
        // ToDo: add button to start playing
        // ToDo: add button to pause playing
        // ToDo: add button to stop playing

        // ToDo: control buttons visibility
    }
}
