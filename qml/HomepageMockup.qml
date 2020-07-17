import QtQuick 2.0
import Felgo 3.0

Page {
    id: page
    title: "Homepage mockup"

anchors.topMargin: dp(50)


    AppFlickable {
        anchors.fill: parent
        contentHeight: content.height



        Grid {
            id: content
            width: parent.width

            columns: 1

            spacing: dp(10)


            Repeater {
                id: repeater

                model: 20
                width: content.width

                 Loader {
                    sourceComponent: {

                        if (index < 5) {
                            issue;
                        } else if (index===6 || index === 20) {
                            ads;
                        } else if (index > 6){
                            article;
                        }



                    }
                }
            }






        }





    }


    Component {
        id: issue
        AppImage {

            width: page.width
            height: dp(200)
            source: "https://picsum.photos/id/" + Math.floor(Math.random() * 100 + 100) + "/600/400"
            AppText { text: "issue"; anchors.centerIn: parent; color: "white" }
        }
    }

    Component {
        id: article
        AppImage {

            width: page.width
            height: dp(200)
            source: "https://picsum.photos/id/" + Math.floor(Math.random() * 100 + 100) + "/600/400"
            AppText { text: "issue"; anchors.centerIn: parent; color: "white" }
        }
    }

    Component {
        id: ads
        AppListView{
            id: row
            width: page.width
            height: dp(220)
            orientation: ListView.Horizontal
            model: app.ads.sort(() => 0.5 - Math.random()).slice(0, 5);
            spacing: dp(10)

            property real rowColor: index * 0.03
            delegate: AppPaper {
                height: adImage.height
                width: adImage.width
                elevated: false
                AppImage{
                    id:adImage
                height: dp(200)
                fillMode: Image.PreserveAspectFit

                source: modelData.src
            }
            }
        }
    }



}
