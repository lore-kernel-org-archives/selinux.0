Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4H5C99H005749
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 01:12:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 40mfYc1jRzzrKYR
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 05:12:04 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 40mfYb2TxWzrKYF
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 05:12:03 +0000 (UTC)
Received: by mail-pl0-f67.google.com with SMTP id w19-v6so1778395plq.4
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 22:12:02 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Date: Thu, 17 May 2018 13:11:16 +0800
Message-Id: <20180517051117.48454-5-jason@perfinion.com>
In-Reply-To: <20180517051117.48454-1-jason@perfinion.com>
References: <20180517051117.48454-1-jason@perfinion.com>
Subject: [PATCH 4/5] restorecond: Musl compatibility for GLOB_BRACE
 and GLOB_TILDE
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

musl doesn't implement GLOB_BRACE and GLOB_TILDE, so simply don't use
them there. This affects restorecond -u but braces are not used in the
example configs. GLOB_TILDE is on the roadmap[1] for musl 1.1.21 so
restorecond -u should be fine soon.

[1]: https://wiki.musl-libc.org/roadmap.html

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 restorecond/restore.c | 13 ++++++++-----
 restorecond/watch.c   |  8 ++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/restorecond/restore.c b/restorecond/restore.c
index cf04e962..f6e30001 100644
--- a/restorecond/restore.c
+++ b/restorecond/restore.c
@@ -1,11 +1,14 @@
-/*
- * Note that the restorecond(8) service build links with these functions.
- * Therefore any changes here should also be tested against that utility.
- */
-
 #include "restore.h"
 #include <glob.h>
 
+#ifndef GLOB_TILDE
+#define GLOB_TILDE 0
+#endif
+
+#ifndef GLOB_BRACE
+#define GLOB_BRACE 0
+#endif
+
 char **exclude_list;
 int exclude_count;
 
diff --git a/restorecond/watch.c b/restorecond/watch.c
index 691df824..98ff797b 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -20,6 +20,14 @@
 #include "stringslist.h"
 #include "utmpwatcher.h"
 
+#ifndef GLOB_TILDE
+#define GLOB_TILDE 0
+#endif
+
+#ifndef GLOB_BRACE
+#define GLOB_BRACE 0
+#endif
+
 /* size of the event structure, not counting name */
 #define EVENT_SIZE  (sizeof (struct inotify_event))
 /* reasonable guess as to size of 1024 events */
-- 
2.16.1
