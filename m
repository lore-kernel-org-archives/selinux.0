Subject: [PATCH 1/7] SELinux: remove crazy contortions around proc
To: selinux@tycho.nsa.gov
From: Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov
Date: Fri, 24 Aug 2012 15:58:45 -0400
Message-ID: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We check if the fsname is proc and if so set the proc superblock security
struct flag.  We then check if the flag is set and use the string 'proc'
for the fsname instead of just using the fsname.  What's the point?  It's
always proc...  Get rid of the useless conditional.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c33c880..df35dd6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -673,7 +673,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		sbsec->flags |= SE_SBPROC;
 
 	/* Determine the labeling behavior to use for this filesystem type. */
-	rc = security_fs_use((sbsec->flags & SE_SBPROC) ? "proc" : sb->s_type->name, &sbsec->behavior, &sbsec->sid);
+	rc = security_fs_use(sb->s_type->name, &sbsec->behavior, &sbsec->sid);
 	if (rc) {
 		printk(KERN_WARNING "%s: security_fs_use(%s) returned %d\n",
 		       __func__, sb->s_type->name, rc);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
