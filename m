Subject: [PATCH 5/7] SELinux: do all flags twiddling in one place
To: selinux@tycho.nsa.gov
From: Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov
Date: Fri, 24 Aug 2012 15:59:14 -0400
Message-ID: <20120824195914.22970.71487.stgit@paris.rdu.redhat.com>
In-Reply-To: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
References: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently we set the initialize and seclabel flag in one place.  Do some
unrelated printk then we unset the seclabel flag.  Eww.  Instead do the flag
twiddling in one place in the code not seperated by unrelated printk.  Also
don't set and unset the seclabel flag.  Only set it if we need to.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/hooks.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8d2bff9..2121e1d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -389,8 +389,6 @@ static int sb_finish_set_opts(struct super_block *sb)
 		}
 	}
 
-	sbsec->flags |= (SE_SBINITIALIZED | SE_SBLABELSUPP);
-
 	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
 		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
 		       sb->s_id, sb->s_type->name);
@@ -399,11 +397,11 @@ static int sb_finish_set_opts(struct super_block *sb)
 		       sb->s_id, sb->s_type->name,
 		       labeling_behaviors[sbsec->behavior-1]);
 
-	if (sbsec->behavior == SECURITY_FS_USE_GENFS ||
-	    sbsec->behavior == SECURITY_FS_USE_MNTPOINT ||
-	    sbsec->behavior == SECURITY_FS_USE_NONE ||
-	    sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
-		sbsec->flags &= ~SE_SBLABELSUPP;
+	sbsec->flags |= SE_SBINITIALIZED;
+	if (sbsec->behavior == SECURITY_FS_USE_XATTR ||
+	    sbsec->behavior == SECURITY_FS_USE_TRANS ||
+	    sbsec->behavior == SECURITY_FS_USE_TASK)
+		sbsec->flags |= SE_SBLABELSUPP;
 
 	/* Special handling for sysfs. Is genfs but also has setxattr handler*/
 	if (strncmp(sb->s_type->name, "sysfs", sizeof("sysfs")) == 0)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
