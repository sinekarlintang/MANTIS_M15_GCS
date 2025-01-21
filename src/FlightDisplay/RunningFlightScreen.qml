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
    id: runningflightScreen
    visible: true
    QGCPalette { id: qgcPal }

    property bool isVideoFullScreen: false // Tracks which view is fullscreen

    // FlyView {
    //     id: flyView
    //     visible: isVideoFullScreen ? false : true // Conditional fullscreen
    //     anchors.fill: isVideoFullScreen ? null : parent // Conditional fullscreen
    //     width: isVideoFullScreen ? null : parent.width
    //     height: isVideoFullScreen ? null : parent.height
    //     anchors.bottom: isVideoFullScreen ? null : undefined
    //     anchors.right: isVideoFullScreen ? null : undefined
    //     anchors.bottomMargin: isVideoFullScreen ? null : undefined
    //     anchors.rightMargin: isVideoFullScreen ? null : undefined
    //     z: isVideoFullScreen ? 1 : 0 // Ensure correct stacking
    // }
    FlyViewMap {
        id: flyViewMap
        anchors.fill: isVideoFullScreen ? null : parent // Conditional fullscreen
        width: isVideoFullScreen ? parent.width * 0.3 : parent.width
        height: isVideoFullScreen ? parent.height * 0.3 : parent.height
        anchors.bottom: isVideoFullScreen ? parent.bottom : undefined
        anchors.right: isVideoFullScreen ? parent.right : undefined
        anchors.bottomMargin: isVideoFullScreen ? 20 : undefined
        anchors.rightMargin: isVideoFullScreen ? 20 : undefined
        z: isVideoFullScreen ? 1 : 0 // Ensure correct stacking
    }

    RunningFlightWidgetLayer {
        id:                     widgetLayer
        anchors.top:            parent.top
        anchors.bottom:         parent.bottom
        anchors.left:           parent.left
        anchors.right:          parent.right
        z:                      _fullItemZorder + 1
        parentToolInsets:       _toolInsets
        mapControl:             _mapControl
        visible:                runningflightScreen.visible
    }

    FlightDisplayViewVideo {
        id: flightVideo
        anchors.fill: isVideoFullScreen ? parent : null // Conditional fullscreen
        width: isVideoFullScreen ? parent.width : parent.width * 0.3
        height: isVideoFullScreen ? parent.height : parent.height * 0.3
        anchors.bottom: isVideoFullScreen ? undefined : parent.bottom
        anchors.right: isVideoFullScreen ? undefined : parent.right
        anchors.bottomMargin: isVideoFullScreen ? undefined : 20
        anchors.rightMargin: isVideoFullScreen ? undefined : 20
        z: isVideoFullScreen ? 0 : 1 // Ensure correct stacking
    }

    MouseArea {
        id: flyViewMouseArea
        width:  parent.width * 0.3
        height: parent.height * 0.3
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 20
        anchors.rightMargin: 20
        onClicked: isVideoFullScreen ? isVideoFullScreen = false : isVideoFullScreen = true   // Swap to default view when clicked
        z : 2
    }

}
