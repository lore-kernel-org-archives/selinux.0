From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2] selinux: enable genfscon labeling for sysfs and pstore
 files
Date: Fri, 22 May 2015 08:33:47 -0400
Message-Id: <1432298027-19412-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Support per-file labeling of sysfs and pstore files based on
genfscon policy entries.  This is safe because the sysfs
and pstore directory tree cannot be manipulated by userspace,
except to unlink pstore entries.
This provides an alternative method of assigning per-file labeling
to sysfs or pstore files without needing to set the labels from
userspace on each boot.  The advantages of this approach are that
the labels are assigned as soon as the dentry is first instantiated
and userspace does not need to walk the sysfs or pstore tree and
set the labels on each boot.  The limitations of this approach are
that the labels can only be assigned based on pathname prefix matching.
You can initially assign labels using this mechanism and then change
them at runtime via setxattr if allowed to do so by policy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Suggested-by: Dominick Grift <dac.override@gmail.com>
---
This version adds support for pstore as well as sysfs.

 security/selinux/hooks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2c616f6..070ab05 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -727,7 +727,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	if (strcmp(sb->s_type->name, "proc") == 0)
 		sbsec->flags |= SE_SBPROC | SE_SBGENFS;
 
-	if (strcmp(sb->s_type->name, "debugfs") == 0)
+	if (!strcmp(sb->s_type->name, "debugfs") ||
+	    !strcmp(sb->s_type->name, "sysfs") ||
+	    !strcmp(sb->s_type->name, "pstore"))
 		sbsec->flags |= SE_SBGENFS;
 
 	if (!sbsec->behavior) {
-- 
2.1.0
