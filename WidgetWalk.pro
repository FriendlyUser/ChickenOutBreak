# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.yourcompany.wizardEVP.WidgetWalk
PRODUCT_VERSION_NAME = 2.0.0
PRODUCT_VERSION_CODE = 2

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = ""

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

PRODUCT_LICENSE_KEY = "485343BD2C5E67B2EF464B873528FE86B87766CC460A81F41F2BDBE6FDA7EB84EFFAC505DFAACB0C932A030424B0AE3DB19BB8CBA3D2751F27AFEB9E32CB14B6D92D124F447B1BA406AB575F5D41FE28F619D226274C8C92BFA03806F9B9C0A9872386D68BD98DF7F93B61DD525E53B706D89D9892BCA3A7CDA24F16AD6DDCE0F315CA19D1210777017014F379A011615BE98CDC0A5EEF39ADA9561CF7F8AB0B3F7B09D3237B60F75550B6DED61C65824766CC2144E1B3CAA0879EF12AE8384EA6390E267FDE9AF73AE821FF0DC3B0CD94ADB07578403A9225DF955E57FD36463580CBEF0A9E66C0864BF861C29BA4C27F65D09DA6B2D15C7DCE21DAC59D3E81F0C4F3C6B5BB3F827DBA3168086A7F6D170E8CCA246F11B027B47D54F3065768F25F040405C59E417286FE34DB930B2A8A36F9B1FBD573E4B3B3AAAB3F035FD7E8B192BAC0089FAD31B1416BF45EA26EE9BD9535356915365510056EE29CF385311F42AC964238C134E9F87F11B1980EBCDABE047E3B6F859CAF507625163F7E"
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
