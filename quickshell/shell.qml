import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import "modules"

PanelWindow {
    id: win

    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true
    color: "transparent"
    mask: Region {
	x: 0
	y: 0
	width: win.width
	height: win.height
	intersection: Intersection.Xor
    }

    Bar {}

    Item {
	id: border

	anchors.fill: parent

	Rectangle {
	    anchors.fill: parent
	    color: "#1a1b26"
	    //color: "red"

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
		//anchors.margins: 5
		anchors.leftMargin: 0
		//radius: 20
		topLeftRadius: 20
		bottomLeftRadius: 20
	    }
	}
    }
}
