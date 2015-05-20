From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux: enable genfscon-based labeling for sysfs files
Date: Wed, 20 May 2015 12:44:06 -0400
Message-Id: <1432140246-9776-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Support per-file labeling of sysfs files based on genfscon
policy entries.  This is safe because the sysfs directory
tree cannot be manipulated by userspace.  This provides an
alternative method of assigning per-file labeling to sysfs
files without needing to set the labels from userspace.
The advantages of this approach are that the labels are
assigned as soon as the dentry is first instantiated
and userspace does not need to walk the sysfs tree and
set each label.  The limitations of this approach are that
the labels can only be assigned based on pathname prefix
matching.  You can initially assign labels using this
mechanism and then change them at runtime via setxattr
if allowed to do so by policy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Reported-by:  Dominick Grift <dac.override@gmail.com>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 56c90dd..727cc07 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -726,7 +726,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	if (strcmp(sb->s_type->name, "proc") == 0)
 		sbsec->flags |= SE_SBPROC | SE_SBGENFS;
 
-	if (strcmp(sb->s_type->name, "debugfs") == 0)
+	if (!strcmp(sb->s_type->name, "debugfs") ||
+	    !strcmp(sb->s_type->name, "sysfs"))
 		sbsec->flags |= SE_SBGENFS;
 
 	if (!sbsec->behavior) {
-- 
2.1.0
