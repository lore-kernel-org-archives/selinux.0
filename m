From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 2/8] libsepol: build on mac
Date: Mon, 17 Oct 2016 16:24:04 -0400
Message-Id: <1476735850-7844-2-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
References: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Correct the build issues on mac, mostly flags for tools.
libsepol and cil now build completley on Mac with a
simple make command.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index b0c901f..7856213 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -30,6 +30,13 @@ LOBJS += $(sort $(patsubst %.c,%.lo,$(sort $(wildcard $(CILDIR)/src/*.c)) $(CIL_
 override CFLAGS += -I$(CILDIR)/include
 endif
 
+LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=$(LIBMAP),-z,defs
+
+OS := $(shell uname)
+ifeq ($(OS), Darwin)
+LD_SONAME_FLAGS=-install_name,$(LIBSO)
+LDFLAGS += -undefined dynamic_lookup
+endif
 
 all: $(LIBA) $(LIBSO) $(LIBPC)
 
@@ -39,7 +46,7 @@ $(LIBA):  $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS) $(LIBMAP)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(LOBJS) -Wl,-soname,$(LIBSO),--version-script=$(LIBMAP),-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(LOBJS) -Wl,$(LD_SONAME_FLAGS)
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
-- 
1.9.1
