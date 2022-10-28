import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    height: parent.height * 0.07
    flat: true
    width: parent.width * 0.6
    property alias buttonText: contentText.text
    property alias backgroundColor: backgroundRect.border.color

    background: Rectangle {
        id: backgroundRect
        border.color: "green"
        border.width: 1
        radius: 5
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

    }

    contentItem: Text {
        id: contentText
        text: "CONTINUAR"
        color: "#005500"
        width: parent.width
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            backgroundRect.color = backgroundColor
            contentText.color = "white"
        }

        onExited: {
            backgroundRect.color = "white"
            contentText.color = backgroundColor
        }

        onClicked: {
            parent.clicked()
        }
    }
}
