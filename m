Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBLIMCXi021001
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 13:22:14 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 19ACA5647EF
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 19:22:09 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 2/7] libsemanage/tests: make tests standalone
Date: Wed, 21 Dec 2016 19:20:59 +0100
Message-Id: <20161221182104.16967-3-nicolas.iooss@m4x.org>
In-Reply-To: <20161221182104.16967-1-nicolas.iooss@m4x.org>
References: <20161221182104.16967-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In order to run libsemanage tests, libsepol and libselinux source
directories need to exist next to libsemanage source directory. This
prevents tests to be run when using the released package.

As libsemanage tests only use public API of libselinux and libsepol,
link with the shared objects which are likely to be installed on the
system (or at least present in $DESTDIR).

While at it, drop TESTSRC variable as it was used to find libsemanage
internal headers but not the tested library (libsemanage.a). Moreover
add ../src/libsemanage.a to the target dependencies of the test
executable in order to rebuild it after libsemanage.a has been updated.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/tests/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 4b81fed70660..bd6a5fd74906 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -1,23 +1,23 @@
+PREFIX ?= $(DESTDIR)/usr
+LIBDIR ?= $(PREFIX)/lib
+
 # Add your test source files here:
 SOURCES = $(wildcard *.c)
 
-# Point this variable to the libsemanage source directory you want to test:
-TESTSRC=../src
-
 # Add the required external object files here:
-LIBS = ../src/libsemanage.a ../../libselinux/src/libselinux.a ../../libsepol/src/libsepol.a
+LIBS = ../src/libsemanage.a -L$(LIBDIR) -lselinux -lsepol
 
 ###########################################################################
 
 EXECUTABLE = libsemanage-tests
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
-INCLUDE = -I$(TESTSRC) -I$(TESTSRC)/../include
+INCLUDE = -I../src -I../include
 LDFLAGS += -lcunit -lustr -lbz2 -laudit
 OBJECTS = $(SOURCES:.c=.o) 
 
 all: $(EXECUTABLE) 
 
-$(EXECUTABLE): $(OBJECTS) 
+$(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	$(CC) $(OBJECTS) $(LIBS) $(LDFLAGS) -o $@
 
 %.o: %.c
-- 
2.11.0
