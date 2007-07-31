include(../mumble.pri)

TEMPLATE	=app
CONFIG  += network
CONFIG(static) {
	QMAKE_LFLAGS += -static
}
CONFIG	-= gui
QT += network sql xml
QT -= gui
TARGET = murmur
DBFILE  = murmur.db
LANGUAGE	= C++
RC_FILE = murmur.rc
FORMS = 
HEADERS = Server.h Register.h Cert.h
SOURCES = murmur.cpp Server.cpp ServerDB.cpp Register.cpp Cert.cpp Messages.cpp
HEADERS	+= ../ACL.h ../Group.h ../Channel.h ../Connection.h ../Player.h
SOURCES += ../ACL.cpp ../Group.cpp ../Channel.cpp ../Message.cpp ../Connection.cpp ../Player.cpp ../Timer.cpp

DIST = DBus.h ServerDB.h


PRECOMPILED_HEADER = murmur_pch.h
DIST = murmur.pl murmur.ini link.pl dbusauth.pl Commands.txt mysql.sql mysql_upgrade.sql

win32 {
  CONFIG += gui
  QT += gui
  HEADERS += DBus_fake.h
  LIBS	+= -lws2_32
  RESOURCES	+= murmur.qrc
  SOURCES += Tray.cpp
  HEADERS += Tray.h
  INCLUDEPATH += /dev/openssl/outinc
  LIBS += -L/dev/openssl/out -leay32
}

unix {
  SOURCES += DBus.cpp
  HEADERS += DBus_real.h
  CONFIG += qdbus link_pkgconfig
  PKGCONFIG += openssl
}
