Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3OI0Nbq026576
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 14:00:27 -0400
Received: by mail-pg0-f68.google.com with SMTP id 63so6000594pgh.0
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 11:00:25 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/7] libselinux: PCRE_LDFLAGS is actually LDLIBS
Date: Tue, 25 Apr 2017 01:59:55 +0800
Message-Id: <20170424175959.20998-3-jason@perfinion.com>
In-Reply-To: <20170424175959.20998-1-jason@perfinion.com>
References: <20170424175959.20998-1-jason@perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

>From Make's manual:

LDFLAGS
Extra flags to give to compilers when they are supposed to invoke the
linker, ‘ld’, such as -L. Libraries (-lfoo) should be added to the
LDLIBS variable instead.

LDLIBS
Library flags or names given to compilers when they are supposed to
invoke the linker, ‘ld’. Non-library linker flags, such as -L, should go
in the LDFLAGS variable.

https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libselinux/Makefile       | 6 +++---
 libselinux/src/Makefile   | 6 +++---
 libselinux/utils/Makefile | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 98776d2..1ecab17 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -22,12 +22,12 @@ export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST
 USE_PCRE2 ?= n
 ifeq ($(USE_PCRE2),y)
 	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 $(shell $(PKG_CONFIG) --cflags libpcre2-8)
-	PCRE_LDFLAGS := $(shell $(PKG_CONFIG) --libs libpcre2-8)
+	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre2-8)
 else
 	PCRE_CFLAGS := $(shell $(PKG_CONFIG) --cflags libpcre)
-	PCRE_LDFLAGS := $(shell $(PKG_CONFIG) --libs libpcre)
+	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre)
 endif
-export PCRE_CFLAGS PCRE_LDFLAGS
+export PCRE_CFLAGS PCRE_LDLIBS
 
 OS := $(shell uname)
 export OS
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index a277b87..c685e66 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -91,7 +91,7 @@ override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
 LD_SONAME_FLAGS=-install_name,$(LIBSO)
 endif
 
-PCRE_LDFLAGS ?= -lpcre
+PCRE_LDLIBS ?= -lpcre
 
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 
@@ -143,8 +143,8 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,$(LD_SONAME_FLAGS)
-	ln -sf $@ $(TARGET) 
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LDLIBS) -ldl -L$(LIBDIR) -Wl,$(LD_SONAME_FLAGS)
+	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
 	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 954da45..68f7097 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -46,7 +46,7 @@ endif
 
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 LDLIBS += -L../src -lselinux -L$(LIBDIR)
-PCRE_LDFLAGS ?= -lpcre
+PCRE_LDLIBS ?= -lpcre
 
 ifeq ($(ANDROID_HOST),y)
 TARGETS=sefcontext_compile
@@ -54,7 +54,7 @@ else
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 endif
 
-sefcontext_compile: LDLIBS += $(PCRE_LDFLAGS) ../src/libselinux.a -lsepol
+sefcontext_compile: LDLIBS += $(PCRE_LDLIBS) ../src/libselinux.a -lsepol
 
 sefcontext_compile: sefcontext_compile.o ../src/regex.o
 
-- 
2.10.2
