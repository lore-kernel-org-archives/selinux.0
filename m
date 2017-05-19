Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4JH9jJq012042
 for <selinux@tycho.nsa.gov>; Fri, 19 May 2017 13:09:45 -0400
Received: by mail-pf0-f182.google.com with SMTP id n23so42604489pfb.2
 for <selinux@tycho.nsa.gov>; Fri, 19 May 2017 10:09:42 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] selinux: Remove redundant check for unknown labeling behavior
Date: Fri, 19 May 2017 10:09:32 -0700
Message-Id: <20170519170932.67192-1-mka@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The check is already performed in ocontext_read() when the policy is
loaded. Removing the array also fixes the following warning when
building with clang:

security/selinux/hooks.c:338:20: error: variable 'labeling_behaviors'
    is not needed and will not be emitted
    [-Werror,-Wunneeded-internal-declaration]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 security/selinux/hooks.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e67a526d1f30..2e0227b0304f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -398,18 +398,6 @@ static void superblock_free_security(struct super_block *sb)
 	kfree(sbsec);
 }
 
-/* The file system's label must be initialized prior to use. */
-
-static const char *labeling_behaviors[7] = {
-	"uses xattr",
-	"uses transition SIDs",
-	"uses task SIDs",
-	"uses genfs_contexts",
-	"not configured for labeling",
-	"uses mountpoint labeling",
-	"uses native labeling",
-};
-
 static inline int inode_doinit(struct inode *inode)
 {
 	return inode_doinit_with_dentry(inode, NULL);
@@ -524,10 +512,6 @@ static int sb_finish_set_opts(struct super_block *sb)
 		}
 	}
 
-	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
-		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
-		       sb->s_id, sb->s_type->name);
-
 	sbsec->flags |= SE_SBINITIALIZED;
 	if (selinux_is_sblabel_mnt(sb))
 		sbsec->flags |= SBLABEL_MNT;
-- 
2.13.0.303.g4ebf302169-goog
