import QtQuick 2.0
import Felgo 3.0

Page {
    id: sciencePage
    title: "Science"

    property string serverUrl: "https://newsapi.org/v2/top-headlines?country=us&apiKey=3b6f61e54cd14f30a72553d068260f12&category=science"
    property var jsonData: undefined
    property int index: 0

    Component.onCompleted: {
        console.log('science page oncompleted')

        let request = HttpRequest
        .get(serverUrl)
        .timeout(5000)
        .then(function(res){
            console.log('res')
            console.log('body ' +res.body)
            jsonData =res.body['articles']
        })
        .catch(function(err){
            console.log('err')
            console.log(err.message)
            console.log(err.response)
        });
    }

    Repeater {
        id:repeater
        model: jsonData

        AppCard {
            id: card

            topMargin: (repeater.count - index)* dp(15)
            rightMargin:index * dp(1)
            //                            leftMargin: index * dp(1)
            width: parent.width - dp(repeater.count)
            paper.background.height: dp(300)

            margin: dp(15)
            paper.radius: dp(5)
            paper.height: dp(800)
            paper.shadow.spread: dp(0)
            paper.shadow.glowRadius: dp(0)
            paper.elevated: true
            swipeEnabled: true
            cardSwipeArea.rotationFactor: 0.05

            header: SimpleRow {
                imageSource: modelData.urlToImage
                text: modelData.source.name
                detailText: modelData.title

                enabled: false
                image.radius: image.width/2
                image.fillMode: Image.PreserveAspectCrop
                style: StyleSimpleRow {
                    showDisclosure: false
                    backgroundColor: "transparent"
                }
            }

            content: AppText { text: modelData.title; width: parent.width ; padding: dp(15) }

            media: AppImage {
                width: parent.width
                fillMode: Image.PreserveAspectFit
                height: dp(200)
                source: modelData.urlToImage

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Qt.openUrlExternally(modelData.url)
                    }
                }
            }
            actions: Row {
                IconButton {
                    icon: IconType.thumbsup
                }
                IconButton {
                    icon: IconType.sharealt
                }
                AppButton {
                    text: "Follow"
                    flat: true
                }
            }
        }
    }

}
