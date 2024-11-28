Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BDC1917F1
	for <selinux@vger.kernel.org>; Thu, 28 Nov 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812891; cv=none; b=DcZM/+BJArop/g6qvfhYq4OeYvB6Mlg5nO6asg22thOSEQV999b0YdcE2WFWHSYEzFHLpxci3JU0TvszQ3Aw+SLkt1N+b7Duws+pEk+Xoyis9txJhnPh4+sfT4tI9xyDbSwAslUi5+KffL+VHZL2lKda2WcLSbOpxtNeCvAtzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812891; c=relaxed/simple;
	bh=1PlOEWegQPUJvsMGZ4rV0xZAldzhtoljINwqJNjHGY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lWL2zL7h8irZUY/vXSKbM8GDXafar4oY17/SXaPVO7MgAN2WuggET65PAy0y2a4dIVvheAmnXuFuQG0/A8ErtJOOHWRquNr5kGair68lRVeK/RhWROoAH95o1mmeKCi8lAIKQqRXde1aPYBh/ekgXYWiXl3wEXDigl4m1Yv0b5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=eHqj4Nqr; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="eHqj4Nqr"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732812885;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KI3DYMtFmUmCkQD6xi72HdFhm9w1FOg0CRiJH2v1gY8=;
	b=eHqj4Nqr4kIGfmoTZV3TEDy+11qnO8wP7fiFJsUJzjxMjL66W9UnuZrbgt4bNOUgYySnlR
	PtRmjho/93B5iSI51QMlsNrejyzXbYzGGrux80B1xnTtEAmG/egbTme9Kz45WI3619vl3p
	sROBYqb1LfTsGkvYhQkVMHxG1tUyz3eKV8hwwdpsidnEj/Cf+ERKyFnj2vSLmScBlXCzQF
	KY/kwosvzRA/j79SOZKPfNUUOrQihy5d/89YGAb5KWcdZbijWi8txAPWkxIii8CwEQb+lT
	gtuVovULabx2s5hlxuGtBu8KFJ24xdsNNgp91kdRJLrcv1d75SxY0I4G78h+wQ==
To: selinux@vger.kernel.org
Cc: Steve Langasek <steve.langasek@canonical.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] Always build for LFS mode on 32-bit archs.
Date: Thu, 28 Nov 2024 17:54:36 +0100
Message-ID: <20241128165436.93649-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Steve Langasek <steve.langasek@canonical.com>

Maintains the type signature of the existing matchpathcon_filespec_add()
entry point on 32-bit archs but maps the API to a new
matchpathcon_filespec_add64() entry point that takes a 64-bit ino_t argument
instead.

Software on 32-bit Linux ports which historically use a 32-bit time_t (thus
affected by the y2038 problem) have, as a precondition of migrating to
64-bit time_t, that they also migrate to large filesystem support because
glibc does not provide entry points for the cross-product of
(LFS: yes, LFS: no) x (time_t: 32, time_t: 64).

In order to support smooth migration of such operating systems from 32-bit
time_t to 64-bit time_t, it is useful for libselinux to:

- provide entry points on 32-bit systems for both LFS and non-LFS variants
  of the API (as glibc itself does)
- use LFS internally for all filesystem calls (just in case)
- map the API call to the correct implementation based on the build
  environment of the caller.

Signed-off-by: Steve Langasek <steve.langasek@canonical.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Originally posted https://lore.kernel.org/selinux/ZeQuOBwQ2eSbkUAS@homer.dodds.net/1.2-0001-Always-build-for-LFS-mode-on-32-bit-archs.patch

v2:
 - Adjusted version in libselinux.map
 - check for __BITS_PER_LONG availability in matchpathcon.c similar to
   selinux.h
 - add static asserts, it's better to fail hard at compile time instead
   of having a silent ABI break
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/Makefile                  |  6 ++++++
 libselinux/include/selinux/selinux.h |  5 +++++
 libselinux/src/Makefile              |  2 ++
 libselinux/src/libselinux.map        |  5 +++++
 libselinux/src/matchpathcon.c        | 26 ++++++++++++++++++++++++++
 libselinux/utils/Makefile            |  2 ++
 6 files changed, 46 insertions(+)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 6d9e2736..a50b6491 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -34,6 +34,12 @@ PCRE_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(PCRE_MODULE))
 PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs $(PCRE_MODULE))
 export PCRE_MODULE PCRE_CFLAGS PCRE_LDLIBS
 
+USE_LFS ?= y
+ifeq ($(USE_LFS),y)
+	LFS_CFLAGS := -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
+endif
+export LFS_CFLAGS
+
 OS := $(shell uname)
 export OS
 
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 50419a7c..f3cf5a20 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -1,8 +1,10 @@
 #ifndef _SELINUX_H_
 #define _SELINUX_H_
 
+#include <stdint.h>
 #include <sys/types.h>
 #include <stdarg.h>
+#include <asm/bitsperlong.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -535,6 +537,9 @@ extern int matchpathcon_index(const char *path,
    with the same inode (e.g. due to multiple hard links).  If so, then
    use the latter of the two specifications based on their order in the 
    file contexts configuration.  Return the used specification index. */
+#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64 && __BITS_PER_LONG < 64
+#define matchpathcon_filespec_add matchpathcon_filespec_add64
+#endif
 extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *file);
 
 /* Destroy any inode associations that have been added, e.g. to restart
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 41cfbdca..9909eb40 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -89,6 +89,8 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Werror -Wno-aggregate-return \
           $(EXTRA_CFLAGS)
 
+override CFLAGS += $(LFS_CFLAGS)
+
 LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro
 
 ifeq ($(OS), Darwin)
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 5e00f45b..02f5b761 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -252,3 +252,8 @@ LIBSELINUX_3.5 {
     getpidprevcon;
     getpidprevcon_raw;
 } LIBSELINUX_3.4;
+
+LIBSELINUX_3.8 {
+  global:
+    matchpathcon_filespec_add64;
+} LIBSELINUX_3.5;
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 967520e4..15f9353d 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -1,3 +1,4 @@
+#include <assert.h>
 #include <sys/stat.h>
 #include <string.h>
 #include <errno.h>
@@ -261,6 +262,31 @@ int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
 	return -1;
 }
 
+#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64 && __BITS_PER_LONG < 64
+/* alias defined in the public header but we undefine it here */
+#undef matchpathcon_filespec_add
+
+/* ABI backwards-compatible shim for non-LFS 32-bit systems */
+
+static_assert(sizeof(unsigned long) == sizeof(__ino_t), "inode size mismatch");
+static_assert(sizeof(unsigned long) == sizeof(uint32_t), "inode size mismatch");
+static_assert(sizeof(ino_t) == sizeof(ino64_t), "inode size mismatch");
+static_assert(sizeof(ino64_t) == sizeof(uint64_t), "inode size mismatch");
+
+extern int matchpathcon_filespec_add(unsigned long ino, int specind,
+                                     const char *file);
+
+int matchpathcon_filespec_add(unsigned long ino, int specind,
+                              const char *file)
+{
+	return matchpathcon_filespec_add64(ino, specind, file);
+}
+#else
+
+static_assert(sizeof(unsigned long) == sizeof(ino_t), "inode size mismatch");
+
+#endif
+
 /*
  * Evaluate the association hash table distribution.
  */
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index f3cedc11..0d7095b1 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -36,6 +36,8 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-overflow=5 \
           $(EXTRA_CFLAGS)
 
+override CFLAGS += $(LFS_CFLAGS)
+
 ifeq ($(OS), Darwin)
 override CFLAGS += -I/opt/local/include -I../../libsepol/include
 override LDFLAGS += -L../../libsepol/src -undefined dynamic_lookup
-- 
2.45.2

