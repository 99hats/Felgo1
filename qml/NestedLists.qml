import QtQuick 2.0
import Felgo 3.0

Page {
    id: page
    title: "Nested List"
    anchors.topMargin: dp(100)

    AppListView{
        id:list
        height: parent.height
        width: parent.width
        //            clip: true
        spacing: 10
        model: 10
        delegate:


            Loader {
            sourceComponent: {
                if (index % 5 == 0){
                    ads;
                } else {
                    article;
                }
            }
        }
        //            footer: VisibilityRefreshHandler {
        //              onRefresh: {
        //                  console.log('onRefresh')
        //                  parent.parent.model *= 2
        //              }
        //            }
    }



    Component {
        id: ads
        AppListView{
            id: row
            width: page.width
            height: dp(220)
            orientation: ListView.Horizontal
            model: app.ads.sort(() => 0.5 - Math.random()).slice(0, 8);
            spacing: dp(10)

            property real rowColor: index * 0.03
            delegate:
                AppImage{
                id:adImage
                height: dp(200)
                fillMode: Image.PreserveAspectFit

                source: modelData.src

            }
        }
    }

    Component {
        id: article
        AppImage {

            width: app.width
            height: app.width * 2/3

            fillMode: Image.PreserveAspectFit

            source: "https://picsum.photos/id/" + Math.floor(Math.random() * 100 + 100) + "/900/600"
            AppText { text: parent.index; anchors.centerIn: parent; color: "white" }
        }
    }

}
