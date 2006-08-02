Subject: [PATCH] secon makefile
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kvance@tresys.com
Content-Type: text/plain
Date: Wed, 02 Aug 2006 10:19:14 -0400
Message-Id: <1154528354.9510.2.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The secon makefile did not correctly respect DESTDIR so building the
repo in a sandbox was not possible. 

Index: policycoreutils/secon/Makefile
===================================================================
--- policycoreutils/secon/Makefile	(revision 1025)
+++ policycoreutils/secon/Makefile	(working copy)
@@ -1,18 +1,19 @@
 # secon tool - command-line context
 PREFIX ?= ${DESTDIR}/usr
+INCLUDEDIR ?= $(PREFIX)/include
 BINDIR ?= $(PREFIX)/bin
+MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= ${PREFIX}/lib
 
-LIBSELINUX      = -lselinux
-
-WARNS=-W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal -O1
+WARNS=-W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
 VERSION = $(shell cat ../VERSION)
-CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -DVERSION=\"$(VERSION)\" 
+CFLAGS ?= $(WARNS) -O1
+override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(INCLUDEDIR) 
+LDLIBS = -lselinux -L$(LIBDIR)
 
 all: secon
 
-secon: secon.o
-	$(CC) -o $@ $< $(LIBS) $(LINKFLAGS) $(LIBSELINUX) 
+secon: secon.o 
 
 install-nogui: install
 
@@ -25,9 +26,6 @@
 relabel:
 	/sbin/restorecon $(BINDIR)/secon
 
-%.o:  %.c
-	$(CC) $(WARNS) $(CFLAGS) -c $<
-
 clean:
 	rm -f *.o core* secon *~ *.bak
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
