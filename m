Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUT2m001588
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:29 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIURJc002783
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:28 GMT
Message-Id: <20070423213728.095165000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:03 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 08/33] libsemanage: DESTDIR support in INCLUDE and safe test target
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added DESTDIR support for the INCLUDE variable.  Tests will now properly use the DESTDIR headers instead of the system headers.

Tests are always cleaned before they are remade.

---
 libsemanage/tests/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: selinux-pms-support/libsemanage/tests/Makefile
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/Makefile
+++ selinux-pms-support/libsemanage/tests/Makefile
@@ -12,7 +12,7 @@ LIBS = ../src/libsemanage.a ../../libsel
 EXECUTABLE = libsemanage-tests
 CC = gcc
 CFLAGS = -c -g -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
-INCLUDE = -I$(TESTSRC) -I$(TESTSRC)/../include/semanage
+INCLUDE = -I$(TESTSRC) -I$(TESTSRC)/../include/semanage -I$(DESTDIR)/usr/include
 LDFLAGS = -lcunit
 OBJECTS = $(SOURCES:.c=.o) 
 
@@ -27,6 +27,6 @@ $(EXECUTABLE): $(OBJECTS) 
 clean distclean: 
 	rm -rf $(OBJECTS) $(EXECUTABLE)
 
-test: all 
+test: clean all
 	./$(EXECUTABLE)
 

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
