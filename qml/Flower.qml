import QtQuick 2.0
import Felgo 3.0


    Image {
        id: flowerImage
        width: 400
        height: 400
        fillMode: Image.PreserveAspectFit
        source: "https://bloximages.newyork1.vip.townnews.com/montereycountyweekly.com/content/tncms/assets/v3/editorial/a/e5/ae5e3006-bfc0-11ea-8b18-1b42ef5f18c1/5f037e9516899.image.jpg?resize=750%2C717"
        AppCardSwipeArea {

        }

        AppText {
            text : "Flower Power!"
            anchors.centerIn: parent
            color: "white"
        }
    }

