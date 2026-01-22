pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string time: {
        // Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy")
        // Qt.formatDateTime(clock.date, "ddd dd/MM hh:mm")
        Qt.formatDateTime(clock.date, "hh:mm");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
