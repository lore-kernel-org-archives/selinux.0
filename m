From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, dwalsh@redhat.com, seth.forshee@canonical.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC][PATCH] selinux: allow context mounts on tmpfs, ramfs,
 devpts within user namespaces
Date: Wed,  7 Dec 2016 12:16:07 -0500
Message-Id: <1481130967-24760-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

commit aad82892af261b9903cc11c55be3ecf5f0b0b4f8 ("selinux: Add support for
unprivileged mounts from user namespaces") prohibited any use of context
mount options within non-init user namespaces.  However, this breaks
use of context mount options for tmpfs mounts within user namespaces,
which are being used by Docker/runc.  There is no reason to block such
usage for tmpfs, ramfs or devpts.  Exempt these filesystem types
from this restriction.

Before:
sh$ userns_child_exec  -p -m -U -M '0 1000 1' -G '0 1000 1' bash
sh# mount -t tmpfs -o context=system_u:object_r:user_tmp_t:s0:c13 none /tmp
mount: tmpfs is write-protected, mounting read-only
mount: cannot mount tmpfs read-only

After:
sh$ userns_child_exec  -p -m -U -M '0 1000 1' -G '0 1000 1' bash
sh# mount -t tmpfs -o context=system_u:object_r:user_tmp_t:s0:c13 none /tmp
sh# ls -Zd /tmp
unconfined_u:object_r:user_tmp_t:s0 /tmp

Note that this still isn't quite right, and I do not know why yet -
the category (:c13) was dropped.  This works correctly in the init
namespace, and strace of mount shows that it is passing the context
correctly to the kernel and returning 0.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 98a2e92..ef882a3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -839,8 +839,12 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	if (sb->s_user_ns != &init_user_ns) {
 		if (context_sid || fscontext_sid || rootcontext_sid ||
 		    defcontext_sid) {
-			rc = -EACCES;
-			goto out;
+			if (strcmp(sb->s_type->name, "tmpfs") &&
+			    strcmp(sb->s_type->name, "ramfs") &&
+			    strcmp(sb->s_type->name, "devpts")) {
+				rc = -EACCES;
+				goto out;
+			}
 		}
 		if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
 			sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
-- 
2.7.4
