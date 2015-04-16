From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux:  Remove deprecated mudflap option.
Date: Thu, 16 Apr 2015 08:26:00 -0400
Message-Id: <1429187160-24527-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The mudflap run time checker was removed in GCC 4.9.  The
option no longer does anything and triggers a warning from gcc 4.9
and later.  Remove it.  We might want to add -fsanitize=address
to enable AddressSanitizer in its place, but that should be a separate
change.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/Makefile   | 2 +-
 libselinux/utils/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 82cb6ed..ac25c1f 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -59,7 +59,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes \
           -Wmissing-declarations -Wmissing-noreturn -Wmissing-format-attribute \
           -Wredundant-decls -Wnested-externs -Winline -Winvalid-pch -Wvolatile-register-var \
-          -Wdisabled-optimization -Wbuiltin-macro-redefined -Wmudflap -Wpacked-bitfield-compat \
+          -Wdisabled-optimization -Wbuiltin-macro-redefined -Wpacked-bitfield-compat \
           -Wsync-nand -Wattributes -Wcoverage-mismatch -Wmultichar -Wcpp \
           -Wdeprecated-declarations -Wdiv-by-zero -Wdouble-promotion -Wendif-labels -Wextra \
           -Wformat-contains-nul -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index f469924..5499538 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -11,7 +11,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes \
           -Wmissing-declarations -Wmissing-noreturn -Wmissing-format-attribute \
           -Wredundant-decls -Wnested-externs -Winline -Winvalid-pch -Wvolatile-register-var \
-          -Wdisabled-optimization -Wbuiltin-macro-redefined -Wmudflap -Wpacked-bitfield-compat \
+          -Wdisabled-optimization -Wbuiltin-macro-redefined -Wpacked-bitfield-compat \
           -Wsync-nand -Wattributes -Wcoverage-mismatch -Wmultichar -Wcpp \
           -Wdeprecated-declarations -Wdiv-by-zero -Wdouble-promotion -Wendif-labels -Wextra \
           -Wformat-contains-nul -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
-- 
2.1.0
