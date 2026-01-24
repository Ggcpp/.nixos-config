import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

PanelWindow {
    property var sink: Pipewire.defaultAudioSink

    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    implicitWidth: 50
    color: "#1a1b26"

    SystemClock {
        id: clock
        precision: SystemClock.minutes
    }

    PwObjectTracker {
        objects: [sink]
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../logo/nixos.png"
            sourceSize.width: 30
            sourceSize.height: 30
        }

        Repeater {
            model: [ "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]

            Text {
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                anchors.horizontalCenter: parent.horizontalCenter
                text: modelData
                color: isActive ? "#0db9d7" : (ws ? "#7aa2f7" : "#444b6a")
                font { pixelSize: 19; bold: true }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))

                    // Should be in Repeater or a wrapper of it but I can't make it work
                    onWheel: wheel => {
                        if (wheel.angleDelta.y > 0) {
                            Hyprland.dispatch("workspace e-1")
                        } else {
                            Hyprland.dispatch("workspace e+1")
                        }
                    }
                }
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#0db9d7"
            text: Qt.formatDateTime(clock.date, "hh")
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#0db9d7"
            text: Qt.formatDateTime(clock.date, "mm")
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: UPower.onBattery ? "#7aa2f7" : "#0db9d7"
            text: UPower.displayDevice.percentage * 100 + "%"
        }

        Text {
            property int volume: sink && sink.audio ? Math.round(sink.audio.volume * 100) : 0

            anchors.horizontalCenter: parent.horizontalCenter
            color: "#0db9d7"
            text: volume
        }

        Item { Layout.fillHeight: true }
    }
}
