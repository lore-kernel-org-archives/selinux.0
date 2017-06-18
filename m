Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5I7gGF9006170
 for <selinux@tycho.nsa.gov>; Sun, 18 Jun 2017 03:42:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so11800994pge.1
 for <selinux@tycho.nsa.gov>; Sun, 18 Jun 2017 00:41:55 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux utils: override LD{FLAGS,
 LIBS} for libselinux.so in Makefile
Date: Sun, 18 Jun 2017 15:41:49 +0800
Message-Id: <20170618074149.7905-1-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

the utils dir link to libselinux.so which was just built, if LDFLAGS or
LDLIBS were specificed on the make commandline then the search path is
not appended. Add the override directive to fix this.

Gentoo-Bug: https://bugs.gentoo.org/621762

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libselinux/utils/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 5f5368a8..474ee95b 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -46,8 +46,8 @@ override LDFLAGS += -L../../libsepol/src -undefined dynamic_lookup
 endif
 
 override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
-LDFLAGS += -L../src
-LDLIBS += -lselinux
+override LDFLAGS += -L../src
+override LDLIBS += -lselinux
 PCRE_LDLIBS ?= -lpcre
 
 ifeq ($(ANDROID_HOST),y)
-- 
2.13.0
