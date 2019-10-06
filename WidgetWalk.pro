# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.grandfleet.thedrop
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

PRODUCT_LICENSE_KEY = "9DDB398C6A894B32ECA710FEA7DF103F13C4A66D0047185224422E1C4E4297F58F6AAD104794F562A16B3B474B29D9863793F5821F5A7CD3EBF5F34E62B0D310F5969C0B140BFC6D5FD8A139620ED7021E464A3E2B83792E0F043CF0480BD408A6EA8828C0F87329193F25C6F6CD9CC584081DB54223BAFCB9305BD718559A91A9B6CAE33DE0AAF3456762474A44D0864D74E812414933A702801EC3461406754FE651EB4797A27458E29A116F4EC3AC36694C8EBC816593FD1D26B82320B5F43B8484888FEEE0EB592FB89C06B93EA22914CA8AEABAF3DC01FE7504FE6BB5A104AF03BCF1ED3E9339A8B2594A853BA801619125101DCB8EA789B94A0C71644D6722670093258F1B48077C0262217D7BF65E06672A2B0881FC0B18EAE7FD2DC39BD048722526E68BDF08505420E4CB8F52DF660A3ED6E99BC6AF68EEC2504B4DAEF3EBBE42F8736CAAD9B49F6228900447FAF0F77BED3DD0504E7C1EA819562F19B2423FBA624A761AED39FEA5292BD2"
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
