Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1LIwh3J017462
 for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2017 13:58:44 -0500
From: Natanael Copa <ncopa@alpinelinux.org>
To: selinux@tycho.nsa.gov
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] libselinux: allow link with -lfts
Date: Tue, 21 Feb 2017 19:58:21 +0100
Message-Id: <20170221185821.26373-1-ncopa@alpinelinux.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This makes it possible to build libselinux with the external libtfs for
systems which does not implement the non-standard fts. For example musl
libc.

  make FTS_LDFLAGS=-lfts

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
 libselinux/src/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 5640a57..513a9e7 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -92,6 +92,7 @@ LD_SONAME_FLAGS=-install_name,$(LIBSO)
 endif
 
 PCRE_LDFLAGS ?= -lpcre
+FTS_LDFLAGS ?=
 
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 
@@ -143,7 +144,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,$(LD_SONAME_FLAGS)
+	$(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) $(FTS_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,$(LD_SONAME_FLAGS)
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
-- 
2.11.1
