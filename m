Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9B8rtUo020730
 for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2017 04:53:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF2274A702
 for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2017 08:53:50 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 11 Oct 2017 10:53:45 +0200
Message-Id: <20171011085345.31496-1-plautrba@redhat.com>
Subject: [PATCH] libselinux: Add support for pcre2 to pkgconfig
 definition
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When libselinux is built using USE_PCRE2 libselinux.pc needs to require
libpcre2-8 instead of libpcre.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1487521

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/Makefile             | 11 ++++++-----
 libselinux/src/Makefile         |  2 +-
 libselinux/src/libselinux.pc.in |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 1ecab178..16531fe9 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -21,13 +21,14 @@ export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST
 
 USE_PCRE2 ?= n
 ifeq ($(USE_PCRE2),y)
-	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 $(shell $(PKG_CONFIG) --cflags libpcre2-8)
-	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre2-8)
+	PCRE_MODULE := libpcre2-8
+	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8
 else
-	PCRE_CFLAGS := $(shell $(PKG_CONFIG) --cflags libpcre)
-	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre)
+	PCRE_MODULE := libpcre
 endif
-export PCRE_CFLAGS PCRE_LDLIBS
+PCRE_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(PCRE_MODULE))
+PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs $(PCRE_MODULE))
+export PCRE_MODULE PCRE_CFLAGS PCRE_LDLIBS
 
 OS := $(shell uname)
 export OS
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 2408faea..18df75c8 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -148,7 +148,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
 
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
index 2cd04d38..2e90a844 100644
--- a/libselinux/src/libselinux.pc.in
+++ b/libselinux/src/libselinux.pc.in
@@ -7,6 +7,6 @@ Name: libselinux
 Description: SELinux utility library
 Version: @VERSION@
 URL: http://userspace.selinuxproject.org/
-Requires.private: libsepol libpcre
+Requires.private: libsepol @PCRE_MODULE@
 Libs: -L${libdir} -lselinux
 Cflags: -I${includedir}
-- 
2.14.2
