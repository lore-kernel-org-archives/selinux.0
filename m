Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0CKd9pv028012
 for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2015 15:39:09 -0500
Subject: [PATCH] selinux: quiet the filesystem labeling behavior message
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 12 Jan 2015 15:39:01 -0500
Message-ID: <20150112203901.29510.15421.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: davej@codemonkey.org.uk
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

While the filesystem labeling method is only printed at the KERN_DEBUG
level, this still appears in dmesg and on modern Linux distributions
that create a lot of tmpfs mounts for session handling, the dmesg can
easily be filled with a lot of "SELinux: initialized (dev X ..."
messages.  This patch removes this notification for the normal case
but leaves the error message intact (displayed when mounting a
filesystem with an unknown labeling behavior).

Reported-by: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 49fc833..d6b685f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -456,10 +456,6 @@ static int sb_finish_set_opts(struct super_block *sb)
 	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
 		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
 		       sb->s_id, sb->s_type->name);
-	else
-		printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), %s\n",
-		       sb->s_id, sb->s_type->name,
-		       labeling_behaviors[sbsec->behavior-1]);
 
 	sbsec->flags |= SE_SBINITIALIZED;
 	if (selinux_is_sblabel_mnt(sb))
