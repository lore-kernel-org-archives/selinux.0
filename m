Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8AJ2G32015066
 for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2014 15:02:17 -0400
Received: by mail-wi0-f180.google.com with SMTP id ex7so1022010wid.1
 for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2014 12:02:20 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id lq8sm19551448wjb.49.2014.09.10.12.02.17
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 10 Sep 2014 12:02:19 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Use $(PYTHON) instead of "python" in every Makefile
Date: Wed, 10 Sep 2014 21:01:28 +0200
Message-Id: <1410375688-13335-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This fixes the build with "make PYTHON=python2" on systems where python
is python3.

For PYLIBVER and PYTHONLIBDIR definitions, I tested Python 2.5, 2.6, 2.7,
3.3 and 3.4.  For each of them, these commands print the expected result:

    python -c 'import sys;print("python%d.%d" % sys.version_info[0:2])'"
    python -c "from distutils.sysconfig import *;print(get_python_lib(1))"
---
 policycoreutils/audit2allow/Makefile | 3 ++-
 policycoreutils/sandbox/Makefile     | 2 +-
 policycoreutils/semanage/Makefile    | 6 ++++--
 policycoreutils/sepolicy/Makefile    | 5 +++--
 sepolgen/src/sepolgen/Makefile       | 3 ++-
 sepolgen/tests/Makefile              | 4 +++-
 6 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/policycoreutils/audit2allow/Makefile b/policycoreutils/audit2allow/Makefile
index f838b13ef8f7..87d25029dc5f 100644
--- a/policycoreutils/audit2allow/Makefile
+++ b/policycoreutils/audit2allow/Makefile
@@ -1,10 +1,11 @@
+PYTHON ?= python
+
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
-PYTHON ?= /usr/bin/python
 
 all: audit2why
 
diff --git a/policycoreutils/sandbox/Makefile b/policycoreutils/sandbox/Makefile
index 567117038d4e..a6fb3435feb6 100644
--- a/policycoreutils/sandbox/Makefile
+++ b/policycoreutils/sandbox/Makefile
@@ -32,7 +32,7 @@ install: all
 	install -m 644 sandbox.conf $(SYSCONFDIR)/sandbox
 
 test:
-	@python test_sandbox.py -v
+	@$(PYTHON) test_sandbox.py -v
 
 clean:
 	-rm -f seunshare *.o *~
diff --git a/policycoreutils/semanage/Makefile b/policycoreutils/semanage/Makefile
index 8fc8e0b15240..60c36a3a1096 100644
--- a/policycoreutils/semanage/Makefile
+++ b/policycoreutils/semanage/Makefile
@@ -1,9 +1,11 @@
+PYTHON ?= python
+
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % sys.version_info[0:2]')
+PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
 PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
 BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
 
@@ -24,7 +26,7 @@ install: all
 	install -m 644 $(BASHCOMPLETIONS) $(BASHCOMPLETIONDIR)/semanage
 
 test:
-	@python test-semanage.py -a
+	@$(PYTHON) test-semanage.py -a
 clean:
 
 indent:
diff --git a/policycoreutils/sepolicy/Makefile b/policycoreutils/sepolicy/Makefile
index 90f88a514ee4..45edb0c2a499 100644
--- a/policycoreutils/sepolicy/Makefile
+++ b/policycoreutils/sepolicy/Makefile
@@ -1,3 +1,5 @@
+PYTHON ?= python
+
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 SYSCONFDIR ?= $(DESTDIR)/etc/sysconfig
@@ -7,7 +9,6 @@ SBINDIR ?= $(PREFIX)/sbin
 DATADIR ?= $(PREFIX)/share
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
-PYTHON ?= /usr/bin/python
 BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
 SHAREDIR ?= $(PREFIX)/share/sandbox
 override CFLAGS = -I$(PREFIX)/include -DPACKAGE="policycoreutils" -Wall -Werror -Wextra -W  -DSHARED -shared
@@ -27,7 +28,7 @@ sepolgen:
 	ln -sf sepolicy sepolgen
 
 test:
-	@python test_sepolicy.py -v
+	@$(PYTHON) test_sepolicy.py -v
 
 install:
 	$(PYTHON) setup.py install `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
diff --git a/sepolgen/src/sepolgen/Makefile b/sepolgen/src/sepolgen/Makefile
index eadc0aa5afec..9ac765151478 100644
--- a/sepolgen/src/sepolgen/Makefile
+++ b/sepolgen/src/sepolgen/Makefile
@@ -1,4 +1,5 @@
-PYTHONLIBDIR ?= $(shell  python -c "from distutils.sysconfig import *; print get_python_lib(1)")
+PYTHON ?= python
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(1))")
 PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
 
 all:
diff --git a/sepolgen/tests/Makefile b/sepolgen/tests/Makefile
index 56e9a5f77a38..924a9bed6bcd 100644
--- a/sepolgen/tests/Makefile
+++ b/sepolgen/tests/Makefile
@@ -1,3 +1,5 @@
+PYTHON ?= python
+
 clean:
 	rm -f *~ *.pyc
 	rm -f parser.out parsetab.py
@@ -6,4 +8,4 @@ clean:
 	rm -f output
 
 test:
-	python run-tests.py
\ No newline at end of file
+	$(PYTHON) run-tests.py
-- 
2.1.0
