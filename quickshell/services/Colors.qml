pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    property bool isDark: true
    property color background: root.isDark ? "#333333" : "#ffffff"
    property color foreground: root.isDark ? "#dddddd" : "#333333"
}
