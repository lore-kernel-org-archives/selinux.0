Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9MCuq6Q015700
 for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2014 08:56:52 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 1/2] libsemanage: install to LIBDIR instead of SHLIBDIR
Date: Wed, 22 Oct 2014 08:56:20 -0400
Message-ID: <1413982581-19099-2-git-send-email-slawrence@tresys.com>
In-Reply-To: <1413982581-19099-1-git-send-email-slawrence@tresys.com>
References: <1413982581-19099-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The libsemanage Makefile currently installs libsemanage.so.1 into
SHLIBDIR, but links libsemanage.so to libsemanage.so.1 in LIBDIR. This
means things will only work if SHLIBDIR and LIBDIR are the same.
Fortunately, by default, they are the same because the default of
SHLIBDIR is set to PREFIX/lib (same as LIBDIR default) instead of the
standard DESTDIR/lib.  Unfortunately, if a user overrides SHLIBDIR, by
doing something like the following:

    make DESTDIR=~/tmp/ LIBDIR=~/tmp/usr/lib SHLIBDIR=~/tmp/lib install

then a broken symlink is created. Note that in some cases this may still
work even when SHLIBDIR and LIBDIR are not the same, e.g.:

    make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install

But this only works because, in systems like Fedora, /lib is a symlink
to /usr/lib, so SHLIBDIR and LIBDIR are the same even though it doesn't
immediately look like it.

This patch changes the libsemanage Makefile to set the default value of
SHLIBDIR to the standard DESTDIR/lib to prevent confusion, and installs
libsemanage to LIBDIR and completely ignores SHLIBDIR.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsemanage/src/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index edb84cc..d1fcc0b 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -9,7 +9,7 @@ RUBYPREFIX ?= $(notdir $(RUBY))
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(PREFIX)/lib
+SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
 PYINC ?= $(shell pkg-config --cflags $(PYPREFIX))
@@ -139,8 +139,7 @@ swigify: $(SWIGIF)
 install: all 
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
 	install -m 644 $(LIBA) $(LIBDIR)
-	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
-	install -m 755 $(LIBSO) $(SHLIBDIR)
+	install -m 755 $(LIBSO) $(LIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
@@ -157,7 +156,7 @@ install-rubywrap: rubywrap
 	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/semanage.so
 
 relabel:
-	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
+	/sbin/restorecon $(LIBDIR)/$(LIBSO)
 
 clean: 
 	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c *.o *.lo *~
-- 
1.9.3
