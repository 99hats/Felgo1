import QtQuick 2.12
import Felgo 3.0

App {
    id: app
    property string serverUrl: "https://mcweekly-app.firebaseio.com/v10/hometab/blog.json"
    property var jsonData: undefined

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
            jsonData =Object.values(res.body).reverse()
        })
        .catch(function(err){
            console.log(err.message)
            console.log(err.response)
        });
    }

    Navigation {

        NavigationItem {
            title: "Main"
            icon: IconType.home

            NavigationStack {
                id: navigationStack


                Page {
                    id: page
                    title: "Home"


                    titleItem: Row {
                        spacing: dp(6)


                        Image {
                            anchors.verticalCenter: parent.verticalCenter
                            height: titleText.height
                            fillMode: Image.PreserveAspectFit
                            source: "https://bloximages.newyork1.vip.townnews.com/montereycountyweekly.com/content/tncms/assets/v3/editorial/6/5b/65bac51a-7c1a-11e5-a65b-078cfc4fa089/562e83543ae88.image.png"
                            DragHandler { id: dHand}
                        }

                        AppText {
                            id: titleText
                            anchors.verticalCenter: parent.verticalCenter
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
                                navigationStack.push(article, {showAdvancedSettings: true})
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
                                navigationStack.push(article)
                            }
                        }

                    }
                }
            }

        }

        NavigationItem {
            title: "WebView"
            icon: IconType.wifi

            NavigationStack {

                Page {
                    title: "Flickable"

                    FlickResize {
                        width: parent.width
                        height: parent.height
                        source: "https://bloximages.newyork1.vip.townnews.com/montereycountyweekly.com/content/tncms/assets/v3/editorial/a/e5/ae5e3006-bfc0-11ea-8b18-1b42ef5f18c1/5f037e9516899.image.jpg?resize=750%2C717"
                    }
                }
            }
        }


    }

    Component {
        id: article

        Page {
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
