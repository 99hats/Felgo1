import QtQuick 2.0
import Felgo 3.0

Item {
    id: slideButton

    property string icon
    property int size : 36

    width: button.width + 10
    height: button.height + 20

    Rectangle {
        anchors.fill: parent
        color: "white"
        opacity: 0.6
    }

    IconButton {
        x: button.x + 2
        y: button.y + 2
        size: sp(parent.size)
        color: "black"
        icon: slideButton.icon

    }

    IconButton {
        enabled: true
        id: button
        anchors.centerIn: slideButton

        size: sp(parent.size)
        color: "white"
        icon: slideButton.icon

    }


}
