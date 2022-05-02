import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    required property var treeModel
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")



    TreeView {
        id: treeView
        model: treeModel
        anchors.top: button.bottom

        delegate: Item {
            id: root

            implicitWidth: padding + label.x + label.implicitWidth + padding
            implicitHeight: label.implicitHeight * 1.5

            readonly property real indent: 20
            readonly property real padding: 5

            // Assigned to by TreeView:
            required property TreeView treeView
            required property bool isTreeNode
            required property bool expanded
            required property int hasChildren
            required property int depth

            required property int row
            TapHandler {
                onTapped: treeView.toggleExpanded(row)
            }

            Text {
                id: indicator
                visible: root.isTreeNode && root.hasChildren
                x: padding + (root.depth * root.indent)
                anchors.verticalCenter: label.verticalCenter
                text: "▸"
                rotation: root.expanded ? 90 : 0
            }

            Text {
                id: label
                x: padding + (root.isTreeNode ? (root.depth + 1) * root.indent : 0)
                width: root.width - root.padding - x
                clip: true
                text: model.display
            }
        }
    }
}
