import QtQuick
import QtQuick.Controls 2.15
import BuzzerController 1.0

Window {
    width: Qt.platform.os === "android" ?
               Screen.desktopAvailableWidth : 640
    height: Qt.platform.os === "android" ?
                Screen.desktopAvailableHeight : 480
    visible: true
    title: qsTr("RaspBuzzer")
    minimumWidth: labelBeep.width + 20

    Dialog {
        id: dialog
        anchors.centerIn: parent
    }

    BuzzerController {
        id: buzzer

        onErrorOccurred: {
            dialog.title = "Erro ao enviar comando"
            dialog.standardButtons = Dialog.Ok
            dialog.visible = true
        }
    }

    QtObject {
        id: fonts
        property int fontSize: Qt.platform.os === "android" ? 22 : 14
    }

    Rectangle {
        anchors.fill: parent
        color: "green"

        Label {
            id: labelBeep
            text: qsTr("Duração do beep (segundos)")
            color: "white"
            anchors.bottom: sliderTempo.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: fonts.fontSize
        }

        Slider {
            id: sliderTempo
            anchors.centerIn: parent
            from: 1
            to: 5
            value: 2
            stepSize: 1
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: fonts.fontSize

            onMoved: {
                let quantidade = sliderQuantidadeVezes.value
                let tempo = sliderTempo.value

                labelResumo.text = `${quantidade} beep(s) por\n${tempo} segundo(s)`
            }
        }

        Label {
            id: labelBeeps
            text: qsTr("Quantidade de beeps")
            anchors.top: sliderTempo.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: fonts.fontSize
            color: "white"
        }

        Slider {
            id: sliderQuantidadeVezes
            from: 1
            to: 10
            value: 1
            stepSize: 1
            anchors.top: labelBeeps.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: fonts.fontSize

            onMoved: {
                let quantidade = sliderQuantidadeVezes.value
                let tempo = sliderTempo.value

                labelResumo.text = `${quantidade} beep(s) por\n${tempo} segundo(s)`
            }
        }

        Timer {
            id: timerTexto
            interval: 2000
            onTriggered: {
                labelResumo.text = ""
            }
        }

        Label {
            id: labelResumo
            font.pointSize: fonts.fontSize
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: ""
            anchors.top: sliderQuantidadeVezes.bottom
        }

        NuButton {
            id: botaoExecutarAcao
            text: qsTr("Executar")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: fonts.fontSize
            backgroundColor: "#005500"

            onClicked: {
                labelResumo.text = "Acionando carga ..."
                timerTexto.start()
                buzzer.setTempo(sliderTempo.value)
                buzzer.setQuantidade(sliderQuantidadeVezes.value)
                buzzer.acionar()
            }
        }
    }
}
