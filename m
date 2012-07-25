Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6PKd2BV006956
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2012 16:39:03 -0400
Received: by mail-yx0-f181.google.com with SMTP id l3so1282046yen.12
        for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2012 13:39:02 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: William Roberts <bill.c.roberts@gmail.com>,
        William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] Support older compilers by wrapping smc .arch
Date: Wed, 25 Jul 2012 13:38:15 -0700
Message-Id: <1343248695-32278-2-git-send-email-w.roberts@sta.samsung.com>
In-Reply-To: <1343248695-32278-1-git-send-email-w.roberts@sta.samsung.com>
References: <1343248695-32278-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: William Roberts <bill.c.roberts@gmail.com>

Fixes build bug
security/smc/bridge_pub2sec.S:95: Error: selected processor does not support ARM mode `smc #0'

Signed-off-by: William Roberts <w.roberts@sta.samsung.com>
---
 security/smc/bridge_pub2sec.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/security/smc/bridge_pub2sec.S b/security/smc/bridge_pub2sec.S
index 30b8b35..e433380 100644
--- a/security/smc/bridge_pub2sec.S
+++ b/security/smc/bridge_pub2sec.S
@@ -74,7 +74,9 @@ return_from_irq:
 	b	label_smc
 
 label_smc:
-	.arch_extension sec
+#if __GNUC__ >= 4 && __GNUC_MINOR__ >= 6
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
