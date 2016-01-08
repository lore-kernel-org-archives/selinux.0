Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u08EeZd6020168
 for <selinux@tycho.nsa.gov>; Fri, 8 Jan 2016 09:40:35 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] secilc: update dependency information and man page creation
Date: Fri, 8 Jan 2016 09:40:23 -0500
Message-ID: <1452264023-5624-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- Update libsepol dependency to 2.5
- Update Makefile to build the man page when just running 'make'

https://marc.info/?l=selinux&m=145220517200709&w=2

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 secilc/Makefile | 6 +++---
 secilc/README   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/secilc/Makefile b/secilc/Makefile
index 739bf68..9bea186 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -17,11 +17,11 @@ CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align
 
 override CFLAGS += -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 
+all: $(SECILC) man
+
 $(SECILC): $(SECILC_OBJS)
 	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)
 
-all: $(SECILC) man
-
 test: $(SECILC)
 	./$(SECILC) test/policy.cil
 
@@ -46,4 +46,4 @@ clean:
 
 relabel:
 
-.PHONY: all clean test install doc relabel
+.PHONY: all clean test install doc relabel man
diff --git a/secilc/README b/secilc/README
index 4878a27..b11045f 100644
--- a/secilc/README
+++ b/secilc/README
@@ -11,7 +11,7 @@ INTRODUCTION
 DEPENDENCIES
 
 	gcc >= 4.5.1
-	libsepol >= 2.4
+	libsepol >= 2.5
 
 
 BUILD STEPS
-- 
2.5.0
