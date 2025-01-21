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
import QGroundControl.MultiVehicleManager     1.0
import QGroundControl.ShapeFileHelper   1.0
import MAVLink                              1.0
import QGroundControl.Controllers       1.0
Item {
    id: flightmodeScreen
    visible: true
    QGCPalette { id: qgcPal }
    property var    _activeVehicle:     QGroundControl.multiVehicleManager.activeVehicle
    property var    _batteryGroup:                  globals.activeVehicle && globals.activeVehicle.batteries.count ? globals.activeVehicle.batteries.get(0) : undefined
    property var    _batteryPercent:                  _batteryGroup ? _batteryGroup.percentRemaining.value : 0
    property var    _batteryVoltage:                  _batteryGroup ? _batteryGroup.voltage.value : 0
    // property var    missionItem:
        
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
            PlanViewZigZag {
                id:             planView
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
                id: droplet
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 20
                anchors.leftMargin: 20
                text: "Ukuran Droplet"
                font.pixelSize: parent.height * 0.03
                color: qgcPal.colorGrey
            }
            Text {
                id: dropletVal
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 20
                anchors.rightMargin: 20
                text: "490 µm"
                font.pixelSize: parent.height * 0.03
                color: qgcPal.colorGrey
            }
            Text {
                id: luasRute
                anchors.top: droplet.bottom
                anchors.left: parent.left
                anchors.topMargin: 20
                anchors.leftMargin: 20
                text: "Luas Rute"
                font.pixelSize: parent.height * 0.03
                color: qgcPal.colorGrey
            }
            Text {
                id: luasRuteVal
                anchors.top: droplet.bottom
                anchors.right: parent.right
                anchors.topMargin: 20
                anchors.rightMargin: 20
                text: globals.surveyArea
                font.pixelSize: parent.height * 0.03
                color: qgcPal.colorGrey
            }
            Text {
                id: tingkatApl
                anchors.top: luasRute.bottom
                anchors.left: parent.left
                anchors.topMargin: 20
                anchors.leftMargin: 20
                text: globals.tingkatAplikasi
                font.pixelSize: parent.height * 0.03
                color: qgcPal.colorGrey
            }
            TextField {
                id: tingkatField
                anchors.top: tingkatApl.bottom
                anchors.left: parent.left
                anchors.topMargin: 20
                anchors.leftMargin: 20
                width: parent.width - 40
                font.pixelSize: parent.height * 0.03
                horizontalAlignment: TextField.AlignHCenter
                verticalAlignment: TextField.AlignVCenter
                background: Rectangle {
                    color: qgcPal.mantisLightGrey
                    border.color: qgcPal.mapMissionTrajectory
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
            }
            Text {
                id: kecepatan
                anchors.top: tingkatField.bottom
                anchors.left: parent.left
                anchors.topMargin: 20
                anchors.leftMargin: 20
                text: "Kecepatan Terbang (km/h)"
                font.pixelSize: parent.height * 0.03
                color: qgcPal.colorGrey
            }
            TextField {
                anchors.top: kecepatan.bottom
                anchors.left: parent.left
                anchors.topMargin: 20
                anchors.leftMargin: 20
                width: parent.width - 40
                font.pixelSize: parent.height * 0.03
                horizontalAlignment: TextField.AlignHCenter
                verticalAlignment: TextField.AlignVCenter
                background: Rectangle {
                    color: qgcPal.mantisLightGrey
                    border.color: qgcPal.mapMissionTrajectory
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
            }
            Text {
                anchors.bottom: modeLanjutButton.top
                anchors.bottomMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                wrapMode: Text.WordWrap
                text: "Pilih area yang dilalui dengan menu 'Pattern' pada peta."
                color: qgcPal.colorGrey
                font.pixelSize: parent.height * 0.03
                width: parent.width - 40
                horizontalAlignment: Text.AlignHCenter  // Menyusun teks secara horizontal ke tengah
                verticalAlignment: Text.AlignVCenter  // Menyusun teks secara vertikal ke tengah
            }
            Button {
                id: modeLanjutButton
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: parent.height * 0.02
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
                    text: "Lanjut"
                    color: qgcPal.mapMissionTrajectory
                    font.pixelSize: parent.height * 0.3  // Font size based on overlay height
                    // font.bold: true
                }
                onClicked: {
                    // _activeVehicle.flightMode = "QuadPlane Agri"
                    flightmodeScreen.visible = false
                }
            }
        }
    }
}
