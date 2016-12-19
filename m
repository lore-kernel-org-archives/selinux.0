Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBJDCmuG022867
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 08:12:48 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id DE9E5564788
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 14:04:44 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 7/7] libsemanage: remove ustr library from Makefiles,
 README and pkg-config
Date: Mon, 19 Dec 2016 14:04:04 +0100
Message-Id: <20161219130404.11496-8-nicolas.iooss@m4x.org>
In-Reply-To: <20161219130404.11496-1-nicolas.iooss@m4x.org>
References: <20161219130404.11496-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This library is no longer used by libsemanage.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 README                            | 2 +-
 libsemanage/src/Makefile          | 2 +-
 libsemanage/src/libsemanage.pc.in | 2 +-
 libsemanage/tests/Makefile        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/README b/README
index b58150b1bba3..e6f727648205 100644
--- a/README
+++ b/README
@@ -2,7 +2,7 @@ Please submit all bug reports and patches to selinux@tycho.nsa.gov.
 Subscribe via selinux-join@tycho.nsa.gov.
 
 Build dependencies on Fedora:
-yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig ustr-devel xmlto redhat-rpm-config
+yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig xmlto redhat-rpm-config
 
 To build and install everything under a private directory, run:
 make DESTDIR=~/obj install install-pywrap
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index df5809645a00..92c829be234d 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -91,7 +91,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsemanage.pc.in
index 81e1805b0826..d3eaa06299c4 100644
--- a/libsemanage/src/libsemanage.pc.in
+++ b/libsemanage/src/libsemanage.pc.in
@@ -7,7 +7,7 @@ Name: libsemanage
 Description: SELinux management library
 Version: @VERSION@
 URL: http://userspace.selinuxproject.org/
-Requires.private: libselinux libsepol ustr
+Requires.private: libselinux libsepol
 Libs: -L${libdir} -lsemanage
 Libs.private: -lbz2
 Cflags: -I${includedir}
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index bd6a5fd74906..3fe7d16f3e72 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -12,7 +12,7 @@ LIBS = ../src/libsemanage.a -L$(LIBDIR) -lselinux -lsepol
 EXECUTABLE = libsemanage-tests
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 INCLUDE = -I../src -I../include
-LDFLAGS += -lcunit -lustr -lbz2 -laudit
+LDFLAGS += -lcunit -lbz2 -laudit
 OBJECTS = $(SOURCES:.c=.o) 
 
 all: $(EXECUTABLE) 
-- 
2.11.0
