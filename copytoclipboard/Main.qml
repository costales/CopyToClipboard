import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Content 1.3

MainView {
    id: root
    applicationName: "copytoclipboard.costales"

    width: units.gu(40)
    height: units.gu(71)

    backgroundColor: "#ebebeb"

    property var activeTransfer
    ContentPeer {
        id: picSourceSingle
        contentType: ContentType.Links
        handler: ContentHandler.Source
        selectionType: ContentTransfer.Single
    }

    Timer {
        id: timer
        interval: 400
        onTriggered: Qt.quit()
    }

    Connections {
        target: ContentHub
        onShareRequested: {
            console.log("Share requested: " + transfer.state);
            root.activeTransfer = transfer;
            if (root.activeTransfer.state === ContentTransfer.Charged) {
                console.log("in onsharerequested");
                for (var k in root.activeTransfer.items) {
                    if (root.activeTransfer.items[k].url) {
                        var mimeData = Clipboard.newData();
                        mimeData.text = root.activeTransfer.items[k].url;
                        Clipboard.push(mimeData);
                        mainlabel.visible = false;
                        img.visible = true;
                        timer.start();
                    }
                }
            }
        }
    }

    Page {
        id: pg
        Label {
            id: mainlabel
            anchors.centerIn: parent
            width: parent.width - units.gu(4)
            wrapMode: Text.Wrap
            fontSize: "large"
            text: i18n.tr("Copy to Clipboard is now available in your Share menu from any app.")
            horizontalAlignment: Text.AlignHCenter
            visible: true
        }
        Image {
            id: img
            source: "copied.png"
            visible: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: pg.bottom;
            anchors.bottomMargin: (root.height / 2) - 160 // 40 is top bar height, 160 half of image
            Component.onCompleted: console.log(img.y, pg.height, root.height);
        }

        Label {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.bottomMargin: units.gu(2)
            anchors.rightMargin: units.gu(2)
            text: "Based on a <a href='http://www.kryogenix.org/'>sil</a>\'s work. Maintained by <a href='https://costales.github.io/about/'>Costales</a>"
            fontSize: "small"
            onLinkActivated: Qt.openUrlExternally(link)
        }
    }
}

