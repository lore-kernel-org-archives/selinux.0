Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3OI0Nbp026576
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 14:00:23 -0400
Received: by mail-pf0-f170.google.com with SMTP id a188so15871541pfa.0
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 11:00:22 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/7] libselinux: get pcre CFLAGS/LDFLAGS from pkg-config
Date: Tue, 25 Apr 2017 01:59:54 +0800
Message-Id: <20170424175959.20998-2-jason@perfinion.com>
In-Reply-To: <20170424175959.20998-1-jason@perfinion.com>
References: <20170424175959.20998-1-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Gentoo-Bug: https://bugs.gentoo.org/500674

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libselinux/Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 979e225..98776d2 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -1,5 +1,6 @@
 SUBDIRS = src include utils man
 
+PKG_CONFIG ?= pkg-config
 DISABLE_SETRANS ?= n
 DISABLE_RPM ?= n
 ANDROID_HOST ?= n
@@ -20,10 +21,11 @@ export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST
 
 USE_PCRE2 ?= n
 ifeq ($(USE_PCRE2),y)
-	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8
-	PCRE_LDFLAGS := -lpcre2-8
+	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 $(shell $(PKG_CONFIG) --cflags libpcre2-8)
+	PCRE_LDFLAGS := $(shell $(PKG_CONFIG) --libs libpcre2-8)
 else
-	PCRE_LDFLAGS := -lpcre
+	PCRE_CFLAGS := $(shell $(PKG_CONFIG) --cflags libpcre)
+	PCRE_LDFLAGS := $(shell $(PKG_CONFIG) --libs libpcre)
 endif
 export PCRE_CFLAGS PCRE_LDFLAGS
 
-- 
2.10.2
