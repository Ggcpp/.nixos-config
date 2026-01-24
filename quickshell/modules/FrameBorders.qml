import Quickshell
import QtQuick
import QtQuick.Effects

Item {
    id: root

    required property Item bar

    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "#1a1b26"

        layer.enabled: true
        layer.effect: MultiEffect {
    	maskSource: mask
    	maskEnabled: true
    	maskInverted: true
    	maskThresholdMin: 0.5
    	maskSpreadAtMin: 1
        }
    }

    Item {
        id: mask

        anchors.fill: parent
        visible: false

        layer.enabled: true

        Rectangle {
            anchors.fill: parent
    	    anchors.margins: 10
    	    anchors.leftMargin: bar.implicitWidth
    	    radius: 20
        }
    }
}

