import Felgo 3.0
import QtQuick 2.0
import "pages"
import "helper"

/*/////////////////////////////////////
  NOTE:
  Additional integration steps are needed to use Felgo Plugins, for example to add and link required libraries for Android and iOS.
  Please follow the integration steps described in the plugin documentation of your chosen plugins:
  - Soomla: https://felgo.com/doc/plugin-soomla/

  To open the documentation of a plugin item in Qt Creator, place your cursor on the item in your QML code and press F1.
  This allows to view the properties, methods and signals of Felgo Plugins directly in Qt Creator.

/////////////////////////////////////*/

GameWindow {
    id: gameWindow

    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"
    licenseKey: "1C1446A5379B2EEF8E9DC1882EDBC79D66195FFD8F351A81DBD642033D7344294B620C5E9106AB44E96594BB16111714642B83BD9B00DA69FA242806B639B97E88837D8AE4E86C88DECBB6B433BCDCBB3CA0CCBB4ABE843DABBF1AD4C3703ADA0EB6E7EF6C701E547763CB566E5ABFBACCE49D4DCB26AAC38F95B1DF7D7C768B6C384982F42C359F196A91B208CC9A408D56D645DBDA0639D00250288D87DC49F67ADEEA49C2379E585D1ED7A57CBE486B1EA458D7A50C25C06C627FA0EE38629129DCA487A1875EB849392C4E9BAF1F3DB35B9059BB1341DB9BA0658A1A960FEB3A2F504DD13D272074588894A36247778ED07AE713202EB6712F7D7B4F51869264E8C8CD7E01A42E76EDA0963784992093DCAAF14B413119A93E46B63F620C2FB455CD48A0D8B20BE75D9053174A2057CBF8C2B3AC1DC7661D547605C05AF2958CE3CA97E4C514582876EBE0282F08"
    activeScene: scene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 640
    screenHeight: 960

    Scene {
        id: scene

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 320
        height: 480

        // This item contains example code for the chosen Felgo Plugins
        // It is hidden by default and will overlay the QML items below if shown
        /**
        PluginMainItem {
            id: pluginMainItem
            z: 1           // display the plugin example above other items in the QML code below
            visible: false // set this to true to show the plugin example

            // keep only one instance of these plugin-pages alive within app
            // this prevents crashes due to destruction of plugin items when popping pages from the stack
            property alias soomlaPage: soomlaPage

            SoomlaPage {
                id: soomlaPage
                visible: false
                onPushed: soomlaPage.listView.contentY = soomlaPage.listView.originY
                onPopped: { soomlaPage.parent = pluginMainItem; visible = false }
            }
        }
        */

        // background rectangle matching the logical scene size (= safe zone available on all devices)
        // see here for more details on content scaling and safe zone: https://felgo.com/doc/felgo-different-screen-sizes/
        Rectangle {
            id: rectangle
            anchors.fill: parent
            color: "grey"

            Text {
                id: textElement
                // qsTr() uses the internationalization feature for multi-language support
                text: qsTr("Hello Felgo World")
                color: "#ffffff"
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent

                // when the rectangle that fits the whole scene is pressed, change the background color and the text
                onPressed: {
                    textElement.text = qsTr("Scene-Rectangle is pressed at position " + Math.round(mouse.x) + "," + Math.round(mouse.y))
                    rectangle.color = "black"
                    console.debug("pressed position:", mouse.x, mouse.y)
                }

                onPositionChanged: {
                    textElement.text = qsTr("Scene-Rectangle is moved at position " + Math.round(mouse.x) + "," + Math.round(mouse.y))
                    console.debug("mouseMoved or touchDragged position:", mouse.x, mouse.y)
                }

                // revert the text & color after the touch/mouse button was released
                // also States could be used for that - search for "QML States" in the doc
                onReleased: {
                    textElement.text = qsTr("Hello Felgo World")
                    rectangle.color = "grey"
                    console.debug("released position:", mouse.x, mouse.y)
                }
            }
        }// Rectangle with size of logical scene

        Image {
            id: felgoLogo
            source: "../assets/felgo-logo.png"

            // 50px is the "logical size" of the image, based on the scene size 480x320
            // on hd or hd2 displays, it will be shown at 100px (hd) or 200px (hd2)
            // thus this image should be at least 200px big to look crisp on all resolutions
            // for more details, see here: https://felgo.com/doc/felgo-different-screen-sizes/
            width: 50
            height: 50

            // this positions it absolute right and top of the GameWindow
            // change resolutions with Ctrl (or Cmd on Mac) + the number keys 1-8 to see the effect
            anchors.right: scene.gameWindowAnchorItem.right
            anchors.top: scene.gameWindowAnchorItem.top

            // this animation sequence fades the Felgo logo in and out infinitely (by modifying its opacity property)
            SequentialAnimation on opacity {
                loops: Animation.Infinite
                PropertyAnimation {
                    to: 0
                    duration: 1000 // 1 second for fade out
                }
                PropertyAnimation {
                    to: 1
                    duration: 1000 // 1 second for fade in
                }
            }
        }

    }
}
