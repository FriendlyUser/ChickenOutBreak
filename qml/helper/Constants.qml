pragma Singleton

import QtQuick 2.0

Item {

    // Chartboost
    readonly property string chartboostIosAppId: "53609edd89b0bb726b46c6e0"
    readonly property string chartboostAndroidAppId: "53609f3789b0bb72b4b95836"
    readonly property string chartboostIosAppSignature: "6fed94ffeaf6abb3d5aa85781e59fa2fb83354b8"
    readonly property string chartboostAndroidAppSignature: "c87b4e51a85b76a4bbe41ee880634fc9ae875ca8"

    // Soomla
    property string soomlaSecret: "<your-game-secret>"
    property string soomlaAndroidPublicKey: "<android-public-key>"
    property string creditsCurrencyItemId: "net.vplay.demos.PluginDemo.credits"
    property string creditsPackItemId: "net.vplay.demos.PluginDemo.creditspack"
    property string goodieItemId: "net.vplay.demos.PluginDemo.goodie"
    property string noAdsItemId: "net.vplay.demos.PluginDemo.noads"

}
