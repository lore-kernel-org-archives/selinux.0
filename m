Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0F0Oeia004925
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 19:24:44 -0500
From: John Brooks <john.brooks@jolla.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 1/3] Build libsepol with -O2
Date: Wed, 14 Jan 2015 17:24:01 -0700
Message-Id: <1421281443-4905-2-git-send-email-john.brooks@jolla.com>
In-Reply-To: <1421281443-4905-1-git-send-email-john.brooks@jolla.com>
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1421281443-4905-1-git-send-email-john.brooks@jolla.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

libsepol contains performance sensitive code; in particular, compiler
optimizations save a few minutes off of the optimized policydb hash
tables.

Signed-off-by: John Brooks <john.brooks@jolla.com>
---
 libsepol/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 6450d67..db6c2ba 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -20,7 +20,7 @@ LIBMAP=libsepol.map
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
-CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute
+CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2
 
 override CFLAGS += -I. -I../include -D_GNU_SOURCE
 
-- 
1.9.3
