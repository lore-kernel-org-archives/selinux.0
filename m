Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4H5Bq1g005740
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 01:11:52 -0400
Received: by mail-pf0-f193.google.com with SMTP id q22-v6so1477641pff.11
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 22:11:46 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Date: Thu, 17 May 2018 13:11:15 +0800
Message-Id: <20180517051117.48454-4-jason@perfinion.com>
In-Reply-To: <20180517051117.48454-1-jason@perfinion.com>
References: <20180517051117.48454-1-jason@perfinion.com>
Subject: [PATCH 3/5] setfiles: Musl compatibility for GLOB_BRACE and GLOB_TILDE
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Luis Ressel <aranea@aixah.de>

musl doesn't implement GLOB_BRACE and GLOB_TILDE, so simply don't use
them there. This only affects "setfiles -f", which I don't expect many
people use, and it's undocumented anyway that it expands globs.

Signed-off-by: Luis Ressel <aranea@aixah.de>
Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/setfiles/restore.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 50d192a2..9dea5656 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -6,6 +6,14 @@
 #include "restore.h"
 #include <glob.h>
 
+#ifndef GLOB_BRACE
+#define GLOB_BRACE 0
+#endif
+
+#ifndef GLOB_TILDE
+#define GLOB_TILDE 0
+#endif
+
 char **exclude_list;
 int exclude_count;
 
-- 
2.16.1
