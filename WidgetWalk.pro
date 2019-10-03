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

PRODUCT_LICENSE_KEY = "CB92502CA8FBE7CFBDDCF6A8A9D5945727352E03432BC923C6DCBB40AE3D5CD6A3BEF64CBF3DB4084AED4EEC251696504D3663CD3B27D53FD5C4D235B1C31B41D85901B35E9B5DCD72B17A68EFFB9DF5D67906497C829F2B4490F0A4E0FC14352FA038684C31A0C030A5F9CB705954B60EDA91B7808FB062DD15E102F1366D898EFE682D8BB92CA203351F90AACD400227D7983D325855563F05D4CBD3ABBAE5D9B4377237106F6A2CC997077509D7C726A5DF83A078530418B18E7DCA8D36ABF8333C2ACA8D59295F4EA6D0FEBC623F38F3BC81AFDDD1542ED040CA3C17FE039E65999060A80C33CCED182C0177DAF45E4BD12466910DE742D32376EC1077B83CC16333F6602AECF55249B591F6D45F246098CE2F82D5584E19F3909DBB49243DEFDC82413648D9D744CBFEE6038E9CDCC3BD83ECB8BE3BB28C04E1E2849B9E5401B4EF4095A6E3773ABB32A4802E5BEAD881DA74E9D842B10DE5AF347E9565F61DE8BB9663874B36DC46BC21BE097816CA879C761E99955CCEB31E6D0732FD"
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
