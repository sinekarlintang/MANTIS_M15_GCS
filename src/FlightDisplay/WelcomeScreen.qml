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
    id: welcomeScreen
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
            anchors.topMargin: parent.height * 0.3
            text: qsTr("Hallo, Mantis!")
            color: "white"
            font.pixelSize: parent.height * 0.1  // Font size based on overlay height
            font.bold: true
        }

        // "Perencanaan" Button
        Button {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.5
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
                text: "Perencanaan"
                color: qgcPal.mapMissionTrajectory
                font.pixelSize: parent.height * 0.5  // Font size based on overlay height
                // font.bold: true
            }
            onClicked: {
                welcomeScreen.visible = false
            }
        }

        // "Keluar" Button
        Button {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.65
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
                text: "Keluar"
                color: qgcPal.mapMissionTrajectory
                font.pixelSize: parent.height * 0.5  // Font size based on overlay height
                // font.bold: true
            }
            onClicked: {
                Qt.quit();  // Exits the application
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
