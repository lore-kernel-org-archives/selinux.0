Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1QLuMho004889
 for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2015 16:56:22 -0500
Received: by iecar1 with SMTP id ar1so21835968iec.11
 for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2015 13:56:20 -0800 (PST)
From: Jeff Vander Stoep <jeffv@google.com>
To: jvanderstoep@gmail.com
Subject: [PATCH] avc: remove unnecessary pointer reassignment
Date: Thu, 26 Feb 2015 13:54:17 -0800
Message-Id: <1424987742-15120-1-git-send-email-jeffv@google.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit f01e1af445fa ("selinux: don't pass in NULL avd to avc_has_perm_noaudit")
made this pointer reassignment unnecessary. Avd should continue to reference
the stack-based copy.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 security/selinux/avc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index afcc0ae..3c17dda 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -724,12 +724,10 @@ inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	rcu_read_lock();
 
 	node = avc_lookup(ssid, tsid, tclass);
-	if (unlikely(!node)) {
+	if (unlikely(!node))
 		node = avc_compute_av(ssid, tsid, tclass, avd);
-	} else {
+	else
 		memcpy(avd, &node->ae.avd, sizeof(*avd));
-		avd = &node->ae.avd;
-	}
 
 	denied = requested & ~(avd->allowed);
 	if (unlikely(denied))
-- 
2.2.0.rc0.207.ga3a616c
