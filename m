From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: nicolas.iooss@m4x.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC][PATCH] Make BINDIR/SBINDIR/USRSBINDIR definition and usage
 consistent.
Date: Mon, 19 Jun 2017 15:58:03 -0400
Message-Id: <20170619195803.8485-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As reported by Nicolas Iooss, there are still some inconsistencies
in Makefile variables related to bin and sbin directories.  Fix them.

Before:
$ find . -name Makefile -exec cat {} + |grep '^[A-Z_]*BINDIR' |sort -u
BINDIR=$(PREFIX)/bin
BINDIR ?= $(PREFIX)/bin
BINDIR ?= $(PREFIX)/sbin
SBINDIR ?= $(DESTDIR)/sbin
SBINDIR ?= $(PREFIX)/sbin
USRSBINDIR ?= $(PREFIX)/sbin

After:
$ find . -name Makefile -exec cat {} + | grep '^[A-Z_]*BINDIR' | sort -u
BINDIR ?= $(PREFIX)/bin
SBINDIR ?= $(PREFIX)/sbin

For systems without usrmerge, this changes the default install
location for fixfiles, setfiles, restorecon, restorecon_xattr,
and mcstransd from /sbin to /usr/sbin, and drops the symbolic
link from /usr/sbin/load_policy to /sbin/load_policy.  It
also updates fixfiles with the new paths for setfiles and
restorecon, and drops the absolute path for make relabel
targets, just relying on PATH to be set appropriately.

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/Makefile                         | 4 ++--
 checkpolicy/test/Makefile                    | 2 +-
 libselinux/src/Makefile                      | 2 +-
 libselinux/utils/Makefile                    | 6 +++---
 libsemanage/src/Makefile                     | 2 +-
 libsepol/src/Makefile                        | 2 +-
 mcstrans/src/Makefile                        | 2 +-
 mcstrans/utils/Makefile                      | 6 +++---
 policycoreutils/load_policy/Makefile         | 7 ++-----
 policycoreutils/newrole/Makefile             | 2 +-
 policycoreutils/run_init/Makefile            | 2 +-
 policycoreutils/scripts/Makefile             | 3 +--
 policycoreutils/scripts/fixfiles             | 4 ++--
 policycoreutils/secon/Makefile               | 2 +-
 policycoreutils/setfiles/Makefile            | 2 +-
 python/chcat/Makefile                        | 3 +--
 python/sepolicy/sepolicy/templates/script.py | 2 +-
 restorecond/Makefile                         | 2 +-
 18 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 68e11f2..658b02a 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -53,8 +53,8 @@ install: all
 	install -m 644 checkmodule.8 $(MANDIR)/man8
 
 relabel: install
-	/sbin/restorecon $(BINDIR)/checkpolicy
-	/sbin/restorecon $(BINDIR)/checkmodule
+	restorecon $(BINDIR)/checkpolicy
+	restorecon $(BINDIR)/checkmodule
 
 clean:
 	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index 0a31c5e..59fa446 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -2,7 +2,7 @@
 # Makefile for building the dispol program
 #
 PREFIX ?= $(DESTDIR)/usr
-BINDIR=$(PREFIX)/bin
+BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 4306dd0..bb91465 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -196,7 +196,7 @@ install-rubywrap: rubywrap
 	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/selinux.so
 
 relabel:
-	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
+	restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean-pywrap:
 	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 474ee95..843b0e7 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -1,7 +1,7 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
-USRSBINDIR ?= $(PREFIX)/sbin
+SBINDIR ?= $(PREFIX)/sbin
 INCLUDEDIR ?= $(PREFIX)/include
 
 OS ?= $(shell uname)
@@ -63,8 +63,8 @@ sefcontext_compile: sefcontext_compile.o ../src/regex.o
 all: $(TARGETS)
 
 install: all
-	-mkdir -p $(USRSBINDIR)
-	install -m 755 $(TARGETS) $(USRSBINDIR)
+	-mkdir -p $(SBINDIR)
+	install -m 755 $(TARGETS) $(SBINDIR)
 
 clean:
 	rm -f $(TARGETS) *.o *~
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index f01385c..4ed95f7 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -155,7 +155,7 @@ install-rubywrap: rubywrap
 	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/semanage.so
 
 relabel:
-	/sbin/restorecon $(LIBDIR)/$(LIBSO)
+	restorecon $(LIBDIR)/$(LIBSO)
 
 clean: 
 	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(SWIGRUBYSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c *.o *.lo *~
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 819d261..e39244d 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -89,7 +89,7 @@ install: all
 	$(LN) -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
 
 relabel:
-	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
+	restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
 	-rm -f $(LIBPC) $(LIBMAP) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) $(CIL_GENERATED)
diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index 709e1e0..611bd9b 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -1,7 +1,7 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
-SBINDIR ?= $(DESTDIR)/sbin
+SBINDIR ?= $(PREFIX)/sbin
 INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
 SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
 
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 7e59641..83ac343 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -1,7 +1,7 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
-BINDIR ?= $(PREFIX)/sbin
+SBINDIR ?= $(PREFIX)/sbin
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -Wall
@@ -15,8 +15,8 @@ all: $(TARGETS)
 $(TARGETS): ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
 
 install: all
-	-mkdir -p $(BINDIR)
-	install -m 755 $(TARGETS) $(BINDIR)
+	-mkdir -p $(SBINDIR)
+	install -m 755 $(TARGETS) $(SBINDIR)
 
 test:
 	./mlstrans-test-runner.py ../test/*.test
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index 256d95a..7541b82 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -1,7 +1,6 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
-SBINDIR ?= $(DESTDIR)/sbin
-USRSBINDIR ?= $(PREFIX)/sbin
+SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
@@ -18,8 +17,6 @@ install: all
 	install -m 755 $(TARGETS) $(SBINDIR)
 	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
 	install -m 644 load_policy.8 $(MANDIR)/man8/
-	-mkdir -p $(USRSBINDIR)
-	-ln -sf $(SBINDIR)/load_policy $(USRSBINDIR)/load_policy 
 
 clean:
 	-rm -f $(TARGETS) *.o 
@@ -28,4 +25,4 @@ indent:
 	../../scripts/Lindent $(wildcard *.[ch])
 
 relabel:
-	/sbin/restorecon $(SBINDIR)/load_policy 
+	restorecon $(SBINDIR)/load_policy
diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
index bdefbb8..0f15c43 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -82,4 +82,4 @@ indent:
 	../../scripts/Lindent $(wildcard *.[ch])
 
 relabel: install
-	/sbin/restorecon $(BINDIR)/newrole
+	restorecon $(BINDIR)/newrole
diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
index 7b25952..256b853 100644
--- a/policycoreutils/run_init/Makefile
+++ b/policycoreutils/run_init/Makefile
@@ -49,4 +49,4 @@ indent:
 	../../scripts/Lindent $(wildcard *.[ch])
 
 relabel: install
-	/sbin/restorecon $(SBINDIR)/run_init $(SBINDIR)/open_init_pty
+	restorecon $(SBINDIR)/run_init $(SBINDIR)/open_init_pty
diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts/Makefile
index 969e5c0..ebdec98 100644
--- a/policycoreutils/scripts/Makefile
+++ b/policycoreutils/scripts/Makefile
@@ -1,8 +1,7 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
-USRSBINDIR ?= $(PREFIX)/sbin
-SBINDIR ?= $(DESTDIR)/sbin
+SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= $(PREFIX)/share/locale
 
diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 1aa330f..a988744 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -112,8 +112,8 @@ FORCEFLAG=""
 RPMFILES=""
 PREFC=""
 RESTORE_MODE="DEFAULT"
-SETFILES=/sbin/setfiles
-RESTORECON=/sbin/restorecon
+SETFILES=/usr/sbin/setfiles
+RESTORECON=/usr/sbin/restorecon
 FILESYSTEMSRW=`get_rw_labeled_mounts`
 FILESYSTEMSRO=`get_ro_labeled_mounts`
 SELINUXTYPE="targeted"
diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
index 1f074ff..01adbc0 100644
--- a/policycoreutils/secon/Makefile
+++ b/policycoreutils/secon/Makefile
@@ -24,7 +24,7 @@ install: all
 	install -m 644 secon.1 $(MANDIR)/man1
 
 relabel:
-	/sbin/restorecon $(BINDIR)/secon
+	restorecon $(BINDIR)/secon
 
 clean:
 	rm -f *.o core* secon *~ *.bak
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index 4b8cd81..60120e2 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -1,6 +1,6 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
-SBINDIR ?= $(DESTDIR)/sbin
+SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
diff --git a/python/chcat/Makefile b/python/chcat/Makefile
index 0a52e8f..dbaf9e6 100644
--- a/python/chcat/Makefile
+++ b/python/chcat/Makefile
@@ -1,8 +1,7 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
-USRSBINDIR ?= $(PREFIX)/sbin
-SBINDIR ?= $(DESTDIR)/sbin
+SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= $(PREFIX)/share/locale
 
diff --git a/python/sepolicy/sepolicy/templates/script.py b/python/sepolicy/sepolicy/templates/script.py
index c79738b..e8cfd6f 100644
--- a/python/sepolicy/sepolicy/templates/script.py
+++ b/python/sepolicy/sepolicy/templates/script.py
@@ -81,7 +81,7 @@ sepolicy manpage -p . -d DOMAINTYPE_t
 
 restorecon="""\
 # Fixing the file context on FILENAME
-/sbin/restorecon -F -R -v FILENAME
+/usr/sbin/restorecon -F -R -v FILENAME
 """
 
 tcp_ports="""\
diff --git a/restorecond/Makefile b/restorecond/Makefile
index b1df89f..fac2766 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -55,7 +55,7 @@ install: all
 	-mkdir -p $(SYSTEMDDIR)/system
 	install -m 644 restorecond.service $(SYSTEMDDIR)/system/
 relabel: install
-	/sbin/restorecon $(SBINDIR)/restorecond 
+	restorecon $(SBINDIR)/restorecond
 
 clean:
 	-rm -f restorecond *.o *~
-- 
2.9.4
