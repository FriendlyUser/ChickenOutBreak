# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.grandfleet.wizardEVP.BoyDrop
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = "D35C0A270C7CAE4DAEDCBE4829CA8CAFC50D4381DE176C4E64AEF24143AE1F0E59E1E68118970688D419E191FA34C7E22DAFC42152EB7CC1DCE3CC5CE6D032676C8FFBC610EA92AF3B8A896D6D317F309BDD8F84758A16FF9FEA9DAD51924646C68984F046E8DE5344581EBFAD6E91AE9FC402AECAC49EC41B18DD7F3A9F73D4321A65D70AE54E026DCFFA9218C57E285F593DA47B32A2EEE332303342719EAB0BBBAA86D4A3C8F4A85694D47BE64B5EBA7D6396EF0C7F49DD60EE5C2E0AAFA3651692E591BC6D7CAC83EA402E6BE26B27129718D13685632864A85C53F9A6EAC677170CA60FDC1ABE4EDE91B2BA75F50A6A38A69ED0200651914CB4614A909BAFADF341418B947591A777F3B099E3FF2B3706881623C4D424DAC3B581BA7DBA0ED1FD176188F1F4DA843FC72AAC9D1FC0B7176D7FECB247D4164ABA4B2BCE927EE0A814EC80171CD8628D91C6C0965119B6312E4A1346DE8AC272483C44FDCB"

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

FELGO_PLUGINS += chartboost
FELGO_PLUGINS += soomla

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
