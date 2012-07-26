Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6QIqumN007435
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 14:52:57 -0400
Received: by ggnv5 with SMTP id v5so2425838ggn.12
        for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 11:52:56 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] Fix for build error no support ARM mode `smc #0'
Date: Thu, 26 Jul 2012 11:52:10 -0700
Message-Id: <1343328730-10603-2-git-send-email-w.roberts@sta.samsung.com>
In-Reply-To: <1343328730-10603-1-git-send-email-w.roberts@sta.samsung.com>
References: <1343328730-10603-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fixes build bug:
security/smc/bridge_pub2sec.S:95:
Error: selected processor does not support ARM mode `smc #0'

Change-Id: Ifc1af42e02f850a7077c01abedfa393e07ec516d
Signed-off-by: William Roberts <w.roberts@sta.samsung.com>
---
 security/smc/bridge_pub2sec.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/security/smc/bridge_pub2sec.S b/security/smc/bridge_pub2sec.S
index 30b8b35..d75b8b0 100644
--- a/security/smc/bridge_pub2sec.S
+++ b/security/smc/bridge_pub2sec.S
@@ -74,7 +74,9 @@ return_from_irq:
 	b	label_smc
 
 label_smc:
-	.arch_extension sec
+#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
+        .arch_extension sec
+#endif
 	INVALIDATE_BTB
 	dsb
 	dmb
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
