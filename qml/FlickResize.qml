import QtQuick 2.12
import Felgo 3.0



Rectangle {
    id: root
    color: "black"
    width: parent.width
    height: parent.height

    property alias source : image.source

    Flickable {
        id: flick
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: parent.height


        PinchArea {
            width: Math.max(flick.contentWidth, flick.width)
            height: Math.max(flick.contentHeight, flick.height)

            property real initialWidth
            property real initialHeight
            onPinchStarted: {
                initialWidth = flick.contentWidth
                initialHeight = flick.contentHeight
            }

            onPinchUpdated: {
                // adjust content pos due to drag
                flick.contentX += pinch.previousCenter.x - pinch.center.x
                flick.contentY += pinch.previousCenter.y - pinch.center.y

                // resize content
//                console.log(pinch.center)
                flick.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.previousCenter)
                flick.returnToBounds()

            }

            onPinchFinished: {
                // Move its content within bounds.
                flick.returnToBounds()
            }

                Rectangle {

                    anchors.fill: parent
                    color: "black"

                    width: root.width
                    height: flick.contentHeight

                Image {
                    id: image
                    anchors.fill: parent
                    width: root.width
                    height: root.height

                    fillMode: Image.PreserveAspectFit
                    source: ""
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: {
                            flick.contentWidth = 500
                            flick.contentHeight = 500
                        }
                    }
                }
                }

        }
    }
}
