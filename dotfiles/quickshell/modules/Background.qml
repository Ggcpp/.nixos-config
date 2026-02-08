import Quickshell
import Quickshell.Wayland

PanelWindow {
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Background
    color: "black"

    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true

    Wallpaper {}
}
