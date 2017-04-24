Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3OI0Nbs026576
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 14:00:36 -0400
Received: by mail-pg0-f68.google.com with SMTP id t7so2324448pgt.1
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 11:00:35 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/7] restorecond: get pcre cflags/libs from pkg-config
Date: Tue, 25 Apr 2017 01:59:57 +0800
Message-Id: <20170424175959.20998-5-jason@perfinion.com>
In-Reply-To: <20170424175959.20998-1-jason@perfinion.com>
References: <20170424175959.20998-1-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 restorecond/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index 5016753..b1df89f 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -21,12 +21,15 @@ override CFLAGS += $(DBUSFLAGS)
 
 USE_PCRE2 ?= n
 ifeq ($(USE_PCRE2),y)
-	PCRE_LDFLAGS := -lpcre2-8
+	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 $(shell $(PKG_CONFIG) --cflags libpcre2-8)
+	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre2-8)
 else
-	PCRE_LDFLAGS := -lpcre
+	PCRE_CFLAGS := $(shell $(PKG_CONFIG) --cflags libpcre)
+	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre)
 endif
+export PCRE_CFLAGS PCRE_LDLIBS
 
-LDLIBS += -lselinux $(PCRE_LDFLAGS) $(DBUSLIB) -L$(LIBDIR)
+LDLIBS += -lselinux $(PCRE_LDLIBS) $(DBUSLIB)
 
 all: restorecond
 
-- 
2.10.2
