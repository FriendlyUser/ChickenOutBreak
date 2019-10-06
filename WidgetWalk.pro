# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.yourcompany.wizardEVP.WidgetWalk
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += #    resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

PRODUCT_LICENSE_KEY = "AB6236B3BB070B284A285271C17A1CBEF0144A71141CDEFFB6B3956C56453247E11C3F09CB8C87A18B45F31958987AD1E5F2C1B6779AA7BD7D116C261149AA836EFF01665576A3961D93E9624258A578870FCE650A1C74A965075A48C565D300EFF93DA6EF434CB817D944F4E1903E9CD398282CD43679414992AE96EA5018B37DFA4C5EADBA93E47ACDB69910225A6D557CCBB52235A295AE861DD172A1B00DD237D0F93A8263618A4A5BADBC41B022AF33FAB74AF4AA043E5ED52DF683449D458FCD97B2ACBD1CFFBC949248D1CBDA4F52609E9C82C5A6D7D91B410A1FA2F13EF0B72462F5D659CED50448C055B3B312CA4A61A08A176849D32EE2D083493D3F35BD0CCF97942F10650477530704869A7A1323F9BB9E297157F29D018C56DC9C67C09BE121AB72091A554A646184D4D9EDDABAD3DE950C658AB02E51A96E69D77881A2168396BBA338D763B1F2A9EA8CD8E25008960AF58FB4088C35AEF707C4D277E9DB02EC764A1E79D20197A06A1342E74331A32799BFFFAD67C3E3D940"
FELGO_PLUGINS += soomla     
FELGO_PLUGINS += admob

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}
