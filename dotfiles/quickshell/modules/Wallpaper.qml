import Quickshell
import QtQuick

Item {
    anchors.fill: parent

    Image {
        property string path: "/etc/nixos/dotfiles/hypr/wallpaper.jpg"

        anchors.fill: parent

        source: path
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
    }
}
