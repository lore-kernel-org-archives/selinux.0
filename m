From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH v3] libselinux: add ANDROID_HOST=y build option
Date: Wed, 28 Sep 2016 12:17:59 -0400
Message-Id: <1475079479-22016-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

To build the selinux host configuration, specify
ANDROID_HOST=y on the Make command line.

eg)
make ANDROID_HOST=y
---
 libselinux/Makefile       | 6 +++++-
 libselinux/src/Makefile   | 8 ++++++++
 libselinux/utils/Makefile | 4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index cec2943..f607115 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -2,13 +2,17 @@ SUBDIRS = src include utils man
 
 DISABLE_SETRANS ?= n
 DISABLE_RPM ?= y
+ANDROID_HOST ?= n
+ifeq ($(ANDROID_HOST),y)
+	override DISABLE_SETRANS=y
+endif
 ifeq ($(DISABLE_RPM),y)
 	DISABLE_FLAGS+= -DDISABLE_RPM
 endif
 ifeq ($(DISABLE_SETRANS),y)
 	DISABLE_FLAGS+= -DDISABLE_SETRANS
 endif
-export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS
+export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST
 
 USE_PCRE2 ?= n
 ifeq ($(USE_PCRE2),y)
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 7bf11a8..2c61fad 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -81,6 +81,14 @@ ifneq (,$(filter i386,$(ARCH)))
 TLSFLAGS += -mno-tls-direct-seg-refs
 endif
 
+ifeq ($(ANDROID_HOST),y)
+DISABLE_FLAGS+= -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
+	-DBUILD_HOST
+SRCS= callbacks.c freecon.c label.c label_file.c \
+	label_android_property.c regex.c label_support.c \
+	matchpathcon.c setrans_client.c sha1.c
+endif
+
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./ $(DISABLE_FLAGS)
 
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 7898c08..e56a953 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -28,7 +28,11 @@ override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $
 LDLIBS += -L../src -lselinux -L$(LIBDIR)
 PCRE_LDFLAGS ?= -lpcre
 
+ifeq ($(ANDROID_HOST),y)
+TARGETS=sefcontext_compile
+else
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+endif
 
 sefcontext_compile: LDLIBS += $(PCRE_LDFLAGS) ../src/libselinux.a -lsepol
 
-- 
1.9.1
