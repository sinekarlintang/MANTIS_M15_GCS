// This file is added for MANTIS M15 GCS
import QtQuick          2.11
import QtQuick.Controls 2.4
import QtQuick.Dialogs  1.3
import QtQuick.Layouts  1.11
import QtQuick.Window   2.11

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.Palette       1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.FlightDisplay 1.0
import QGroundControl.FlightMap     1.0

Item {
    id: planScreen
    visible: true
    QGCPalette { id: qgcPal }
    // property string tingkatAplikasi: boxAplText.tingkatApl
    property string tingkatApl: ""
    property var    _activeVehicle:     QGroundControl.multiVehicleManager.activeVehicle
    property real value: 0.00  // Nilai awal
    property real increment: 0.01  // Inkrementasi
    property int interval: 200  // Interval awal (ms)
    property int minInterval: 20  // Interval minimum (ms)
    // Background Image
    Image {
        anchors.fill: parent
        source: "/qmlimages/SplashScreen.svg"  // Replace with the path to your background image
        fillMode: Image.PreserveAspectCrop  // This will maintain aspect ratio while covering the screen
    }
    // Timer untuk mempercepat increment/decrement
    Timer {
        id: actionTimer
        interval: interval
        repeat: true
        running: false
        onTriggered: {
            if (incrementing) {
                value += increment
            } else {
                value -= increment
            }
            if (interval > minInterval) {
                interval = Math.max(minInterval, interval * 0.9)
            }
            actionTimer.interval = interval
        }
    }

    // Logika Increment/Decrement
    property bool incrementing: false
    function startIncrement() {
        incrementing = true
        actionTimer.start()
    }

    function startDecrement() {
        incrementing = false
        actionTimer.start()
    }

    function stopTimer() {
        actionTimer.stop()
        interval = 200  // Reset interval
    }
    // Semi-transparent black rectangle
    Rectangle {
        id: overlay
        anchors.left:   parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width * 0.6  // 60% of the parent width
        height: parent.height * 0.8  // 30% of the parent height
        anchors.margins: parent.width * 0.01
        color: Qt.rgba(0,0,0, 0.7)
        radius: 10          // Rounded corners

        // Greeting Text
        Text {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.1
            text: "Rencana Terbang"
            color: "white"
            font.pixelSize: parent.height * 0.1  // Font size based on overlay height
            font.bold: true
        }
        Rectangle {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.2
            height: parent.height * 0.6
            width: parent.width * 0.8
            color: Qt.rgba(0,0,0, 0)
            Text {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: parent.height * 0.03
                text: "Pilih Format"
                color: qgcPal.mapMissionTrajectory
                font.pixelSize: parent.height * 0.1  // Font size based on overlay height
            }
            // Text {
            //     anchors.top: parent.top
            //     anchors.left: parent.left
            //     anchors.topMargin: parent.height * 0.43
            //     text: "Tingkat Aplikasi"
            //     color: "white"
            //     font.pixelSize: parent.height * 0.1  // Font size based on overlay height
            // }
            ComboBox {
                id: boxAplikasi
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.2
                width: parent.width  // Menyesuaikan lebar ComboBox
                height: parent.height * 0.15
                // color: qgcPal.mantisLightGrey
                // Pilihan dalam ComboBox
                model: ListModel {
                    ListElement { name: "Tingkat Aplikasi (L/m)" }
                    ListElement { name: "Tingkat Aplikasi (L/Ha)" }
                }
                // onTextRoleChanged: PlanScreen.tingkatApl = currentText
                // Menampilkan teks yang dipilih
                Text {
                    id: boxAplText
                    // property string tingkatApl: parent.currentText
                    anchors.top: parent.bottom
                    anchors.topMargin: parent.height * 0.3
                    anchors.left: parent.left
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: parent.currentText
                    color: qgcPal.mapMissionTrajectory
                    font.pixelSize: parent.height * 0.6
                    onTextChanged: {
                        tingkatApl = boxAplText.text
                        globals.tingkatAplikasi = tingkatApl
                    }
                }
            }
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.2
                width: parent.width
                height: parent.height * 0.25
                color: Qt.rgba(0,0,0, 0)
                // Tombol Minus
                // Button {
                //     anchors.left: parent.left
                //     text: "-"
                //     width: parent.width *0.2
                //     height: parent.height
                //     onPressed: startDecrement()
                //     onReleased: stopTimer()
                // }

                // Input Nilai (Editable Box)
                TextField {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    height: parent.height// Tampilkan nilai dengan 2 desimal
                    font.pixelSize: parent.height * 0.6
                    horizontalAlignment: TextField.AlignHCenter
                    verticalAlignment: TextField.AlignVCenter
                    background: Rectangle {
                        color: qgcPal.mantisLightGrey
                        border.color: "black"
                        radius: 5
                    }
                    // Only allow numbers using a DoubleValidator
                    validator: DoubleValidator {
                        bottom: 0  // Minimum allowable value
                        top: 50      // Maximum allowable value
                        decimals: 2      // Allow up to 2 decimal places
                    }
                    // Saat user mengetik angka baru
                    onTextChanged: {
                        let newValue = parseFloat(text)
                        if (!isNaN(newValue)) {
                            value = newValue
                        }
                    }

                    // // Validasi saat input kehilangan fokus
                    // onEditingFinished: {
                    //     if (text === "" || isNaN(parseFloat(text))) {
                    //         text = value.toFixed(2)  // Kembalikan ke nilai sebelumnya
                    //     } else {
                    //         value = parseFloat(text)  // Perbarui nilai
                    //     }
                    // }
                }

                // // Tombol Plus
                // Button {
                //     anchors.right: parent.right
                //     text: "+"
                //     width: parent.width *0.2
                //     height: parent.height
                //     onPressed: startIncrement()
                //     onReleased: stopTimer()
                // }
            }
        }

        Button {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.8
            width: parent.width * 0.6  // 60% of the rectangle's width
            height: parent.height * 0.1  // 15% of the rectangle's height
            background: Rectangle {
                color: qgcPal.mantisMediumGrey  // Button background color
                radius: height / 4  // Fully rounded corners
                border.color: qgcPal.mapMissionTrajectory  // Optional: Border color
                border.width: 1       // Optional: Border thickness
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: _activeVehicle ? "Selanjutnya" : "Menunggu Koneksi Pesawat"
                color: qgcPal.mapMissionTrajectory
                font.pixelSize: parent.height * 0.4  // Font size based on overlay height
                font.bold: true
            }

            onClicked: {
                if (_activeVehicle) {
                    // _activeVehicle.flightMode = "QuadPlane Agri"
                    planScreen.visible = false;
                }
            }
        }
    }

    Rectangle {
        anchors.right:   parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width * 0.35  // 60% of the parent width
        height: parent.height * 0.8  // 30% of the parent height
        anchors.margins: parent.width * 0.01
        color: Qt.rgba(0,0,0, 0)
        radius: 10          // Rounded corners

        Rectangle {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height * 0.48  // 30% of the parent height
            color: qgcPal.mantisLightGrey
            radius: 10          // Rounded corners
            border.width: 2       // Optional: Border thickness
            FlyViewMap {
                id:             flightView
                anchors.fill:   parent
            }
        }
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height * 0.48  // 30% of the parent height
            color: qgcPal.mantisLightGrey
            radius: 10          // Rounded corners
            border.width: 2
            FlightDisplayViewVideo {
                id:             flightVideo
                anchors.fill:   parent
            }
        }
    }
}
