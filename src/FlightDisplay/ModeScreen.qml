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
    id: modeScreen
    visible: true
    QGCPalette { id: qgcPal }
    // Background Image
    Image {
        anchors.fill: parent
        source: "/qmlimages/SplashScreen.svg"  // Replace with the path to your background image
        fillMode: Image.PreserveAspectCrop  // This will maintain aspect ratio while covering the screen
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
            text: "Pengaturan\nPenerbangan"
            color: "white"
            font.pixelSize: parent.height * 0.1  // Font size based on overlay height
            font.bold: true
            horizontalAlignment: Text.AlignHCenter  // Menyusun teks secara horizontal ke tengah
            verticalAlignment: Text.AlignVCenter  // Menyusun teks secara vertikal ke tengah
        }

        Rectangle{
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.4
            width: parent.width * 0.8  // 60% of the rectangle's width
            height: parent.height * 0.5  // 15% of the rectangle's height
            color: Qt.rgba(0,0,0, 0)
            // "Manual" Button

            Rectangle {
                anchors.left: parent.left
                width: parent.width * 0.45   // 60% of the rectangle's width
                height: parent.height  // 15% of the rectangle's height
                color: Qt.rgba(0,0,0, 0)
                Button {
                    anchors.top: parent.top
                    width: parent.width  // 60% of the rectangle's width
                    height: parent.height * 0.3  // 15% of the rectangle's height
                    background: Rectangle {
                        color: qgcPal.mantisMediumGrey  // Button background color
                        radius: height / 4  // Fully rounded corners
                        border.color: qgcPal.mapMissionTrajectory  // Optional: Border color
                        border.width: 1       // Optional: Border thickness
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Manual"
                        color: qgcPal.mapMissionTrajectory
                        font.pixelSize: parent.height * 0.4  // Font size based on overlay height
                        font.bold: true
                    }
                    onClicked: {
                        globals.autoFlight = false
                    }
                }
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 40
                    width: parent.width  // 60% of the rectangle's width
                    height: parent.height * 0.7  // 15% of the rectangle's height
                    color: Qt.rgba(0,0,0, 0)
                    Text {
                        anchors.centerIn: parent
                        wrapMode: Text.WordWrap
                        text: "Mode manual diperuntukkan bagi yang sudah terbiasa dalam menerbangkan drone agrikultur dengan fitur-fitur yang diatur sendiri oleh pengguna."
                        color: "white"
                        font.pixelSize: parent.height * 0.08
                        width: parent.width - 20
                        horizontalAlignment: Text.AlignHCenter  // Menyusun teks secara horizontal ke tengah
                        verticalAlignment: Text.AlignVCenter  // Menyusun teks secara vertikal ke tengah
                    }
                }
            }
            Rectangle {
                anchors.right: parent.right
                width: parent.width * 0.45   // 60% of the rectangle's width
                height: parent.height  // 15% of the rectangle's height
                color: Qt.rgba(0,0,0, 0)
                // "Otomatis" Button
                Button {
                    anchors.top: parent.top
                    width: parent.width // 60% of the rectangle's width
                    height: parent.height * 0.3  // 15% of the rectangle's height
                    background: Rectangle {
                        color: qgcPal.mantisMediumGrey  // Button background color
                        radius: height / 4  // Fully rounded corners
                        border.color: qgcPal.mapMissionTrajectory// Optional: Border color
                        border.width: 1       // Optional: Border thickness
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Otomatis"
                        color: qgcPal.mapMissionTrajectory
                        font.pixelSize: parent.height * 0.4  // Font size based on overlay height
                        font.bold: true
                    }
                    onClicked: {
                        modeScreen.visible = false
                    }
                }
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 40
                    width: parent.width  // 60% of the rectangle's width
                    height: parent.height * 0.7  // 15% of the rectangle's height
                    color: Qt.rgba(0,0,0, 0)
                    Text {
                        anchors.centerIn: parent
                        wrapMode: Text.WordWrap
                        text: "Mode otomatis diperuntukkan bagi yang baru memulai dalam menerbangkan drone agrikultur dengan fitur-fitur yang telah ditetapkan oleh sistem."
                        color: "white"
                        font.pixelSize: parent.height * 0.08
                        width: parent.width - 20
                        horizontalAlignment: Text.AlignHCenter  // Menyusun teks secara horizontal ke tengah
                        verticalAlignment: Text.AlignVCenter  // Menyusun teks secara vertikal ke tengah
                    }
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
