import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "modules"

ShellRoot {
    // Exclusion zone windows
    PanelWindow {
        color: "transparent"
        anchors.top: true
        exclusiveZone: 10
    }
    PanelWindow {
        color: "transparent"
        anchors.right: true
        exclusiveZone: 10
    }
    PanelWindow {
        color: "transparent"
        anchors.bottom: true
        exclusiveZone: 10
    }
    PanelWindow {
        color: "transparent"
        anchors.left: true
        exclusiveZone: bar.implicitWidth
    }
    
    // Overlay window
    PanelWindow {
        id: win
    
        exclusionMode: ExclusionMode.Ignore
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
    
        // Frame borders
        FrameBorders {
            bar: bar
        }
    
        // Vertical Bar
        Bar {
    	    id: bar
        }
    }
}
