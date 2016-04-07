TEMPLATE = aux
TARGET = ShareCopyToClipboard

RESOURCES += ShareCopyToClipboard.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true) \
             $$files(*.content-hub,true) \

CONF_FILES +=  ShareCopyToClipboard.apparmor \
               ShareCopyToClipboard.png \
               copied.png \
               copying.png

AP_TEST_FILES += tests/autopilot/run \
                 $$files(tests/*.py,true)               

OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               $${AP_TEST_FILES} \
               ShareCopyToClipboard.desktop

#specify where the qml/js files are installed to
qml_files.path = /ShareCopyToClipboard
qml_files.files += $${QML_FILES}

#specify where the config files are installed to
config_files.path = /ShareCopyToClipboard
config_files.files += $${CONF_FILES}

#install the desktop file, a translated version is 
#automatically created in the build directory
desktop_file.path = /ShareCopyToClipboard
desktop_file.files = ShareCopyToClipboard.desktop
desktop_file.CONFIG += no_check_exist

INSTALLS+=config_files qml_files desktop_file

DISTFILES += \
    ShareCopyToClipboard.content-hub

