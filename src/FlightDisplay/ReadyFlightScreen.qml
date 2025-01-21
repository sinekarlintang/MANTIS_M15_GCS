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
import QGroundControl.Vehicle       1.0

Item {
    id: readyflightScreen
    visible: true
    property var    _activeVehicle:     QGroundControl.multiVehicleManager.activeVehicle
    property var    _batteryGroup:                  globals.activeVehicle && globals.activeVehicle.batteries.count ? globals.activeVehicle.batteries.get(0) : undefined
    property var    _batteryPercent:                  _batteryGroup ? _batteryGroup.percentRemaining.value : 0
    property var    _batteryVoltage:                  _batteryGroup ? _batteryGroup.voltage.value : 0
    property var _flightModes:      _activeVehicle ? _activeVehicle.flightModes : [ ]

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
        width: parent.width * 0.7  // 60% of the parent width
        height: parent.height * 0.9  // 30% of the parent height
        anchors.margins: parent.width * 0.01
        color: Qt.rgba(0,0,0, 0)
        radius: 10          // Rounded corners

        Rectangle {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height * 0.28
            width: parent.width
            color: Qt.rgba(0,0,0, 0)

            Rectangle {
                anchors.right: parent.right
                width: parent.width * 0.4
                height: parent.height  // 30% of the parent height
                color: qgcPal.mantisLightGrey
                radius: 10          // Rounded corners
                border.width: 2
                FlightDisplayViewVideo {
                    id:             flightVideo
                    anchors.fill:   parent
                }
            }
            Rectangle {
                anchors.left: parent.left
                width: parent.width * 0.56
                height: parent.height  // 30% of the parent height
                color: Qt.rgba(0,0,0, 0)
                radius: 10          // Rounded corners
                // border.width: 2
                Rectangle {
                    anchors.top: parent.top
                    width: parent.width
                    height: parent.height * 0.3 // 30% of the parent height
                    color: qgcPal.mantisMediumGrey
                    radius: 5          // Rounded corners
                    border.width: 1
                    border.color: qgcPal.mapMissionTrajectory
                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 10
                        text: "Battery Capacity"
                        font.pixelSize: parent.height * 0.3
                        color: qgcPal.mapMissionTrajectory
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: _batteryPercent
                        font.pixelSize: parent.height * 0.3
                        color: qgcPal.mapMissionTrajectory
                    }
                    Text {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 10
                        text: "%"
                        font.pixelSize: parent.height * 0.3
                        color: qgcPal.mapMissionTrajectory
                    }
                }
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width
                    height: parent.height * 0.3 // 30% of the parent height
                    color: qgcPal.mantisMediumGrey
                    radius: 5          // Rounded corners
                    border.width: 1
                    border.color: qgcPal.mapMissionTrajectory
                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 10
                        text: "Battery Voltage"
                        font.pixelSize: parent.height * 0.3
                        color: qgcPal.mapMissionTrajectory
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: _batteryVoltage
                        font.pixelSize: parent.height * 0.3
                        color: qgcPal.mapMissionTrajectory
                    }
                    Text {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 10
                        text: "Volt"
                        font.pixelSize: parent.height * 0.3
                        color: qgcPal.mapMissionTrajectory
                    }
                }
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: parent.height * 0.3 // 30% of the parent height
                    color: qgcPal.mantisMediumGrey
                    radius: 5          // Rounded corners
                    border.width: 1
                    border.color: qgcPal.mapMissionTrajectory
                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 10
                        text: "Flight Mode"
                        font.pixelSize: parent.height * 0.3
                        color: qgcPal.mapMissionTrajectory
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: _activeVehicle.flightMode
                        font.pixelSize: parent.height * 0.3
                        color: qgcPal.mapMissionTrajectory
                    }
                }
            }
        }
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height * 0.7
            color: qgcPal.mantisLightGrey
            radius: 10          // Rounded corners
            border.width: 2       // Optional: Border thickness
            FlyViewMap {
                id:             flightView
                anchors.fill:   parent
            }
        }

    }

    Rectangle {
        anchors.right:   parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width * 0.26  // 60% of the parent width
        height: parent.height * 0.9  // 30% of the parent height
        anchors.margins: parent.width * 0.01
        color: Qt.rgba(0,0,0, 0)
        // color: qgcPal.mantisMediumGrey
        // radius: 10          // Rounded corners
        FlyViewInstrumentPanel {
            id:                         instrumentPanel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            width:                      parent.width
            height: parent.height * 0.28
            spacing:                    _toolsMargin
            // visible:                    QGroundControl.corePlugin.options.flyView.showInstrumentPanel && multiVehiclePanelSelector.showSingleVehiclePanel
            // availableHeight:            parent.height - y - _toolsMargin

            property real rightEdgeTopInset: visible ? parent.width - x : 0
            property real topEdgeRightInset: visible ? y + height : 0
        }
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: parent.height * 0.7
            color: qgcPal.mantisMediumGrey
            radius: 10          // Rounded corners
            Text {
                anchors.bottom: readyLanjutButton.top
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Siap Untuk Terbang?"
                font.pixelSize: parent.height * 0.05
                color: qgcPal.colorGrey
            }
            Button {
                id: readyLanjutButton
                // anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                // anchors.bottomMargin: parent.height * 0.02
                width: parent.width * 0.6  // 60% of the rectangle's width
                height: parent.height * 0.1  // 15% of the rectangle's height
                background: Rectangle {
                    color: qgcPal.mantisMediumGrey  // Button background color
                    radius: height / 6  // Fully rounded corners
                    border.color: qgcPal.mapMissionTrajectory // Optional: Border color
                    border.width: 1       // Optional: Border thickness
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Terbang"
                    color: qgcPal.mapMissionTrajectory
                    font.pixelSize: parent.height * 0.3  // Font size based on overlay height
                    // font.bold: true
                }
                onClicked: {
                    _activeVehicle.flightMode = "QuadPlane Agri"
                    _activeVehicle.armed = true
                    readyflightScreen.visible = false
                }
            }
        }
    }
}
