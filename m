Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4H5C3ks005745
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 01:12:03 -0400
Received: by mail-pg0-f67.google.com with SMTP id e1-v6so1279006pga.6
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 22:11:34 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Date: Thu, 17 May 2018 13:11:13 +0800
Message-Id: <20180517051117.48454-2-jason@perfinion.com>
In-Reply-To: <20180517051117.48454-1-jason@perfinion.com>
References: <20180517051117.48454-1-jason@perfinion.com>
Subject: [PATCH 1/5] sestatus: include limits.h for PATH_MAX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

compile fails on musl libc because it cant find PATH_MAX.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/sestatus/sestatus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index 9a92e72f..b37f0353 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -17,6 +17,7 @@
 #include <unistd.h>
 #include <libgen.h>
 #include <ctype.h>
+#include <limits.h>
 
 #define PROC_BASE "/proc"
 #define MAX_CHECK 50
-- 
2.16.1
