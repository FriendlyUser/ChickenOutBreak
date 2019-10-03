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

PRODUCT_LICENSE_KEY = "2B30BD7343E4AE627BD9AAE1956C4437D5736ABE4C1930E5279B9D530323F2C2665EEBC6D337AB374773CC39EA3F1A74120BC6800C51259DEEC8D08B8606D2448BA09B9783E1EB1FF0E98D41A45D06C70EA93DED503C6945BF7DA61299993AAA11EDBAD6C363419C113A807286BF9918A85202902C23CA28BC5A50E314F256B90AE907CF13824C95DFC8438A5D510D1D02B52E5F9A544AE875D270D81D21EDCCB09426932DAB922757735D0DC0630AB04AC72AEF6F9701FBC16463A22E74ABAC96AAC60FE0CB7FEF01F2FB460270DD0CC84F43A25EAD3152A560D134A837FD34D0052DDBBCF696B4AE87605E95A10400F74E2C8D6BE755CFA31B5BFF08ED9DB19DA3FFC7499CC99B2EFD9ABF3C5565B67E0ECA7B43E053CAE23D79506433CD0CFE856D8A348906CEEAF3A32B777B033FA1F3559BDD05DA0AF02608E27522A757628B2BC1CB70ED020575D740259DD9B20C8C2C770A0A1F74FD19183169584609F0F767BA750F521997B913873D930901994CD787F4F1EF7C2A40DB2AEB9BFF59"
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
