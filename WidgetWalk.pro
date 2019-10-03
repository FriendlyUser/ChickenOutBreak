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

PRODUCT_LICENSE_KEY = "E4613A47BD885CCE27AA88B97F0F249C068B303B3FB767A9320AB3F9836E56E20DAB3EABBE3D119A0486DD6D58D7B51EE46C8743F92024EA0116118C01CA531ECBADFB1B417CF9A7EA516B758CF2D75637F8972F8B26F677DC06B2A93D99E6F54EF4C4535BC1F71D890EEB3B2A03824D715A19335F8ECD3AC97A8C5098C128CE02533F176CBE221AA6FDEE14EB6D37A4B98904AB14EEEB16B976866F500EF991D7B4AE9EB859BE65EF2635F27780C890D5D8BB6238FC1E8AB19EA90510B0DE337221B5427BF06E9CE02E2B0E0E96D9CAF123F28BCF37B3C0ADC800F4D9E1DBC4438FC5741D30C67743A349F60643191BF47C7432E60CC08EF4E70410918B592CC6F5B618B5E099B3E0D8A5847E52FB0F20C86DBA8E593E9621FE34C77EF54A6DDEAB6B55A0465FB8337DDED36D6BD4FECB95C5661E36830B94E8A655CD00A841872E5C14D351AF1E3090C5F4C8643CA8DA4B0F13B049AD7738C05977EEDCC4A7DCE3B6F3B8D6CFF5512E54EA5B60180F01E8A215DE5D7139148EEE4BF78FCC66"
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
