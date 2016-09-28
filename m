From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: rename EMFLAGS to DISABLE_FLAGS
Date: Wed, 28 Sep 2016 12:00:23 -0400
Message-Id: <1475078424-21486-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Change EMFLAGS variable, used for setting additional CFLAGS
to DISABLE_FLAGS, to indicate its usage better.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/Makefile       | 6 +++---
 libselinux/src/Makefile   | 6 +++---
 libselinux/utils/Makefile | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index bfeb4b8..41d836c 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -3,12 +3,12 @@ SUBDIRS = src include utils man
 DISABLE_SETRANS ?= n
 DISABLE_RPM ?= n
 ifeq ($(DISABLE_RPM),y)
-	EMFLAGS+= -DDISABLE_RPM
+	DISABLE_FLAGS+= -DDISABLE_RPM
 endif
 ifeq ($(DISABLE_SETRANS),y)
-	EMFLAGS+= -DDISABLE_SETRANS
+	DISABLE_FLAGS+= -DDISABLE_SETRANS
 endif
-export DISABLE_SETRANS DISABLE_RPM EMFLAGS
+export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS
 
 USE_PCRE2 ?= n
 ifeq ($(USE_PCRE2),y)
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index d8a79b4..7bf11a8 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -69,7 +69,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
 
 PCRE_LDFLAGS ?= -lpcre
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(EMFLAGS) $(PCRE_CFLAGS)
+override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 
 SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
 		-Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations
@@ -81,9 +81,9 @@ ifneq (,$(filter i386,$(ARCH)))
 TLSFLAGS += -mno-tls-direct-seg-refs
 endif
 
-SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./ $(EMFLAGS)
+SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./ $(DISABLE_FLAGS)
 
-SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(EMFLAGS)
+SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
 
 all: $(LIBA) $(LIBSO) $(LIBPC)
 
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 0708d6d..7898c08 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -24,7 +24,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
           -fipa-pure-const -Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
           -Werror -Wno-aggregate-return -Wno-redundant-decls
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(EMFLAGS) $(PCRE_CFLAGS)
+override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 LDLIBS += -L../src -lselinux -L$(LIBDIR)
 PCRE_LDFLAGS ?= -lpcre
 
-- 
1.9.1
