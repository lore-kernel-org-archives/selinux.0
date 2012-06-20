Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5KFwFNm011795
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2012 11:58:16 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH system/core] add SELinux network labeling script to startup
Date: Wed, 20 Jun 2012 11:58:03 -0400
Message-Id: <1340207887-30359-3-git-send-email-jbrindle@tresys.com>
In-Reply-To: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
References: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Joshua Brindle <jbrindle@tresys.com>

Change-Id: I47100243b04d9629d44c8962eafeacabdcd0e6d2

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 rootdir/init.rc |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rootdir/init.rc b/rootdir/init.rc
index 7131095..1aa7bc1 100644
--- a/rootdir/init.rc
+++ b/rootdir/init.rc
@@ -372,6 +372,10 @@ service console /system/bin/sh
     user shell
     group log
 
+service netlabels /system/bin/selinux-network.sh
+    class core
+    oneshot
+
 on property:ro.debuggable=1
     start console
 
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
