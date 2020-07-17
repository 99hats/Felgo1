import QtQuick 2.12
import Felgo 3.0

App {
    id: app
    property string serverUrl: "https://mcweekly-app.firebaseio.com/v10/hometab.json"
    property var jsonData: undefined
    property var allData: undefined
    property var ads: undefined

    property int index: 0

    onInitTheme: {

        Theme.navigationBar.backgroundColor = "black"
        Theme.colors.textColor = "#313131"

    }
    Component.onCompleted: {
        console.log("on completed running")
        var request = HttpRequest
        .get(serverUrl)
        .then(function(res){
            console.log("image found")
            console.log(res.body['2020-07-02T15:02:00-07:00-be4d2c5e-bc93-11ea-961b-7776a435844c'])
            jsonData =Object.values(res.body.blog).reverse()
            allData = res.body
            ads = Object.values(res.body.ads)
        })
        .catch(function(err){
            console.log(err.message)
            console.log(err.response)
        });
    }

    Navigation {
        drawerMinifyEnabled: true
        navigationMode: navigationModeDefault
        //        drawerInline: true


        headerView: AppText {
            text: "MCW"
        }

        footerView: AppText {
            text: "Footer"
        }

        navigationDrawerItem: Text {
            text: "Open"
            anchors.centerIn: parent
            color: navigation.navigationDrawerItemPressed ? "red" : "green"
        }


        NavigationItem {
            title: "Main"
            icon: IconType.home

            NavigationStack {
                id: navigationStack


                Page {
                    id: page
                    title: "Home"


                    titleItem:


                        Image {
                        id: logo
                        anchors.verticalCenter: parent.verticalCenter
                        height: titleText.height
                        fillMode: Image.PreserveAspectFit
                        source: "https://bloximages.newyork1.vip.townnews.com/montereycountyweekly.com/content/tncms/assets/v3/editorial/6/5b/65bac51a-7c1a-11e5-a65b-078cfc4fa089/562e83543ae88.image.png"
                        DragHandler { id: dHand; }

                        AppText {
                            id: titleText
                            anchors.left: logo.right
                            anchors.top: logo.top
                            text: page.title
                            font.bold: true
                            font.family: Theme.boldFont.name
                            font.pixelSize: dp(Theme.navigationBar.titleTextSize)
                            color: "white"
                        }
                    }






                    Item {
                        visible: jsondata === undefined

                        anchors.centerIn: parent
                        Icon {
                            anchors.centerIn: parent
                            icon: IconType.refresh
                            NumberAnimation on rotation {
                                loops: Animation.Infinite
                                from: 0
                                to: 360
                                duration: 1000
                            }
                        }
                    }



                    RoundedImage {
                        id: photo
                        source: jsonData !== undefined ? Object.values(jsonData)[index].preview_url: ""
                        anchors.fill: parent
                        //                        anchors.topMargin: dp(20)
                        //                        anchors.bottomMargin: dp(40)
                        //                        anchors.rightMargin: dp(20)
                        //                        anchors.leftMargin: dp(20)
                        //                border.width : 10
                        //                border.color: "#ffffff"

                        radius: dp(2)
                        //                opacity: 0.8

                        fillMode: AppImage.PreserveAspectCrop
                        //                asynchronous: true



                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                console.log("pressed")
                                navigationStack.clearAndPush(article, {showAdvancedSettings: true})
                            }
                        }

                        Rectangle {
                            id: captionBox
                            width: parent.width
                            height: title.height + 20

                            anchors.bottom: parent.bottom
                            color: "white"
                            opacity: 0.5
                            //                    gradient: Gradient {
                            //                           GradientStop { position: 0.0; color: "#ffffff" }
                            //                           GradientStop { position: 1.0; color: "#333333" }
                            //                       }


                        }

                        AppText {
                            id: title
                            width: parent.width -dp(40)
                            anchors.bottom: captionBox.bottom
                            anchors.rightMargin: sp(20)
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.topMargin: dp(20)
                            anchors.horizontalCenterOffset: sp(1)
                            anchors.verticalCenterOffset: dp(2)
                            anchors.bottomMargin: 10
                            text: jsonData !== undefined ? jsonData[index].title: ""
                            horizontalAlignment: Text.AlignHCenter
                            color:"white"
                            font.bold: true

                        }
                        AppText {
                            width: parent.width -dp(40)
                            anchors.bottom: captionBox.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottomMargin: 10
                            anchors.topMargin: dp(20)
                            text: jsonData !== undefined ? Object.values(jsonData)[index].title: ""
                            color: "black"
                            horizontalAlignment: Text.AlignHCenter
                            font.bold: true

                        }
                    }

                }

                SlideButton {
                    size: 48
                    icon: IconType.chevronleft
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left:  parent.left
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            index--
                        }
                    }
                }

                SlideButton {
                    size: 48
                    icon: IconType.chevronright
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right:  parent.right
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            index++
                        }
                    }
                }






            }
        }


        NavigationItem {
            title: "List"
            icon: IconType.list


            NavigationStack {
                splitView: tablet || landscape
                navigationBarShadow: true

                Page {
                    title: "List Page"

                    AppListView {

                        model: jsonData
                        delegate: SimpleRow {
                            autoSizeImage: true
                            //                            badgeValue: "2"
                            //                            badgeColor: "red"
                            detailText: item.title
                            showDisclosure: false
                            imageSource: item.preview_url + "?resize=200"
                            imageMaxSize: dp(90.5)
                            onSelected: {
                                console.log( index)
                                app.index = parseInt(index)
                                navigationStack.popAllExceptFirstAndPush(article)



                            }
                        }

                    }
                }
            }

        }

        NavigationItem {
            title: "Science"
            icon: IconType.coffee

            Loader {
                id: sciencePageLoader
                source: "SciencePage.qml"
                anchors.fill: parent
            }
        }

        NavigationItem {
            title: "Flower"
            icon: IconType.stackoverflow

            NavigationStack {

                Loader {
                    id: flowerPageLoader
                    asynchronous: true
                    source: "https://raw.githubusercontent.com/99hats/Felgo1/master/qml/Flower.qml"
                    anchors.fill: parent

                }

                AppButton {
                    id: reloadButton
                    text: "Reload"
                    width: dp(100)
                    height: dp(50)
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    onClicked: {
                        //                        flowerPageLoader.source = ""
                        flowerPageLoader.source = "https://raw.githubusercontent.com/99hats/Felgo1/master/qml/Flower.qml?"+Math.random()
                    }
                }

                Text {
                    id: reloadText
                    text: flowerPageLoader.source
                    horizontalAlignment: Text.AlignRight
                    anchors.bottom: reloadButton.top
                    anchors.right: reloadButton.right
                }


            }
        }

        NavigationItem {
            title: "Homepage Mockup"
            icon: IconType.filemovieo

            NavigationStack {

                HomepageMockup {
                    anchors .fill: parent
                }
            }
        }

        NavigationItem {
            title: "NestedList"
            icon: IconType.angellist

            NavigationStack {

                navigationBarShadow: true


                NestedLists {
                    anchors.fill: parent
                }
            }
        }

        NavigationItem {
            title: "YouTube"
            icon: IconType.youtube

            NavigationStack  {
                Page {
                    title: "YouTube"

                    YouTubeWebPlayer {
                        width: parent.width
                        videoId: "mfpllV55mWw"
                    }
                }
            }
        }

        NavigationItem {
            title: "Cards"
            icon: IconType.columns

            NavigationStack {

                Page {
                    id: cardPage


                    Repeater {
                        id:repeater
                        model: Object.values(jsonData)

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
                                imageSource: modelData.preview_url
                                text: "news"
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
                                source: modelData.preview_url
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

            }

        }


    }

    Component {
        id: article

        Page {
            id: page
            //                navigationBarHidden: true
            title: " "
            Rectangle {
                color: "white"
                anchors.fill: parent





                AppFlickable {
                    anchors.fill: parent                // The AppFlickable fills the whole page
                    contentWidth: parent.width   // You need to define the size of your content item
                    contentHeight: articleCol.height



                    //                        AppText {
                    //                            anchors.bottom: contentColumn.top
                    //                            anchors.bottomMargin: dp(10)
                    //                            text: "<< return"
                    //                            MouseArea {
                    //                                anchors.fill: parent
                    //                                onClicked: {
                    //                                    console.log("clicked")
                    //                                    navigationStack.pop()
                    //                                }
                    //                            }
                    //                        }


                    AppPaper {
                        width: parent.width
                        elevated: true
                        height: articleCol.height
                        Column {
                            id: articleCol
                            width: parent.width

                            AppImage {
                                id: photo

                                defaultSource: "https://via.placeholder.com/600x400.png"

                                source: jsonData !== undefined ? Object.values(jsonData)[index].preview_url: ""

                                fillMode: Image.PreserveAspectCrop
                                width: parent.width
                                height: GameWindow.height/2

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        //                                        PictureViewer.show(app, Object.values(jsonData)[index].preview_url)
                                        modal.open()
                                    }
                                }

                                AppModal {
                                    id: modal
                                    pushBackContent: navigationStack



                                    FlickResize {
                                        width: parent.width
                                        height: parent.height
                                        source: Object.values(jsonData)[index].preview_url


                                        AppButton {
                                            text: "Close"
                                            anchors.top: parent.top
                                            anchors.right: parent.right
                                            onClicked: modal.close()
                                        }
                                    }



                                }



                            }

                            AppText {
                                id: contentColumn

                                property int xtop: 0

                                //                                onLineLaidOut: {
                                //                                    if (line.number===1){
                                //                                        xtop = line.y
                                //                                    }
                                //                                    line.width = 300

                                //                                    if (line.y > 200 && line.y < 400){
                                //                                        line.x += 400
                                //                                        line.y -= 200
                                //                                    } else if (line.y>= 400 && line.y < 600) {

                                //                                            line.y -= 150
                                //                                        }


                                //                                    console.log(":", line.number, line.x, line.y, line.width)
                                //                                }

                                width: parent.width - dp(40)
                                anchors.horizontalCenter: parent.horizontalCenter


                                onLinkActivated: console.log(link + " link activated")

                                text: jsonData[index].content

                            }
                        }
                    }
                }


            }
        }
    }


}
