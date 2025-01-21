import QtQuick          2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts  1.11
import QtQuick.Dialogs  1.3

import QGroundControl                       1.0
import QGroundControl.Controls              1.0
import QGroundControl.Palette               1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.Controllers           1.0

Rectangle {
    id:     _root
    color:  qgcPal.mantisMediumGrey

    QGCPalette { id: qgcPal }

    Text {
        anchors.centerIn: parent
        text: "Peringatan! Perhatikan Lingkungan Sekitar Saat Terbang!"
        color: qgcPal.text
        font.pixelSize: 14
    }
}
