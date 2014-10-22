Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9MCuq6R015700
 for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2014 08:56:52 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 2/2] libselinux: libsepol: use ln --relative to create .so
 symlinks
Date: Wed, 22 Oct 2014 08:56:21 -0400
Message-ID: <1413982581-19099-3-git-send-email-slawrence@tresys.com>
In-Reply-To: <1413982581-19099-1-git-send-email-slawrence@tresys.com>
References: <1413982581-19099-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The current build system assumes SHLIBDIR is ../../ relative to LIBDIR.
However, this isn't always the case. For example, Arch Linux sets both
LIBDIR and SHLIBDIR to /usr/lib, which results in broken symlinks.

Instead of making that assumption, create .so symlinks using ln
--relative so that the correct relative paths are used. Note that this
adds a dependency for the build system to use coretuils-8.16 or later.

Fixes #2

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libselinux/src/Makefile | 2 +-
 libsepol/src/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 4d07ba6..82cb6ed 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -148,7 +148,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	ln -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index f4b3176..6450d67 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -70,7 +70,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	ln -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
-- 
1.9.3
