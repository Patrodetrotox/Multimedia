import QtQuick 2.6
import Sailfish.Silica 1.0
import QtMultimedia 5.6

Page {
    SoundEffect {
        id: soundEffect
        source: "/usr/share/multimedia/soundeffects/gun.wav"
        volume: volumeSlider.value
        loops: loopSlider.value

        // ToDo: set source to gun.wav in soundeffects folder
        // ToDo: set volume controlled by volumeSlider
        // ToDo: set loops controlled by slider
    }
    PageHeader { title: qsTr("Sound Effect") }
    MouseArea {
        id: touchHandler
        anchors.fill: parent
        // ToDo: play sound effect or stop playing on clicked
        onClicked: {
            if(soundEffect.playing) {

                soundEffect.stop();
            } else {
                soundEffect.play();
            }
        }
    }
    Column {
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        spacing: Theme.paddingLarge

        Slider {
            id: volumeSlider
            width: parent.width
            label: qsTr("Volume")
            value: 0.5
            valueText: value
            minimumValue: 0
            maximumValue: 1
            stepSize: 0.1
        }

        Slider {
            id: loopSlider
            width: parent.width
            label: qsTr("Loops")
            value: 1
            valueText: value
            minimumValue: 0
            maximumValue: 100
            stepSize: 1
        }

        Slider {
            id:progressSlider
            enabled: false
            width: parent.width
            label: qsTr("Current loop")
            value: loopSlider.value - soundEffect.loopsRemaining
            valueText: value
            minimumValue: 0
            maximumValue: loopSlider.value
            stepSize: 1
        }

        // ToDo: add slider to control count of loops
        // ToDo: add slider to show progress
    }
}
