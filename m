Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHMhQQw013961
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 17:43:26 -0500
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHMfiUg029637
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 22:41:44 GMT
Message-Id: <20061117224336.024043000@hp.com>
References: <20061117223842.399078000@hp.com>
Date: Fri, 17 Nov 2006 17:38:51 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 09/13] NetLabel: use the correct CIPSOv4 MLS label limits
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

The CIPSOv4 engine currently has MLS label limits which are slightly larger
than what the draft allows.  This is not a major problem due to the current
implementation but we should fix this so it doesn't bite us later.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 include/net/cipso_ipv4.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: net-2.6.20_netlabel-base-work/include/net/cipso_ipv4.h
===================================================================
--- net-2.6.20_netlabel-base-work.orig/include/net/cipso_ipv4.h
+++ net-2.6.20_netlabel-base-work/include/net/cipso_ipv4.h
@@ -58,10 +58,10 @@
 #define CIPSO_V4_MAP_PASS             2
 
 /* limits */
-#define CIPSO_V4_MAX_REM_LVLS         256
+#define CIPSO_V4_MAX_REM_LVLS         255
 #define CIPSO_V4_INV_LVL              0x80000000
 #define CIPSO_V4_MAX_LOC_LVLS         (CIPSO_V4_INV_LVL - 1)
-#define CIPSO_V4_MAX_REM_CATS         65536
+#define CIPSO_V4_MAX_REM_CATS         65534
 #define CIPSO_V4_INV_CAT              0x80000000
 #define CIPSO_V4_MAX_LOC_CATS         (CIPSO_V4_INV_CAT - 1)
 

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
