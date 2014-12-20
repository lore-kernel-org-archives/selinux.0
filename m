Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBKCTP03021914
 for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2014 07:29:25 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so4176574wid.6
 for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2014 04:29:23 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] security: selinux: avc.c:  Remove unused function
Message-Id: <1419078730-31316-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: James Morris <james.l.morris@oracle.com>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
Date: Sat, 20 Dec 2014 12:30:06 -0000

Remove the function avc_sidcmp() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 security/selinux/avc.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index a18f1fa..afcc0ae 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -517,11 +517,6 @@ out:
 	return rc;
 }
 
-static inline int avc_sidcmp(u32 x, u32 y)
-{
-	return (x == y || x == SECSID_WILD || y == SECSID_WILD);
-}
-
 /**
  * avc_update_node Update an AVC entry
  * @event : Updating event
-- 
1.7.10.4
