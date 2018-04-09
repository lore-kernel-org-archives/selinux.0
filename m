From: Stephen Smalley <sds@tycho.nsa.gov>
To: paul@paul-moore.com
Cc: penguin-kernel@i-love.sakura.ne.jp, dvyukov@google.com,
 jasowang@redhat.com, mst@redhat.com, viro@zeniv.linux.org.uk,
 torvalds@linux-foundation.org, selinux@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon,  9 Apr 2018 14:36:05 -0400
Message-Id: <20180409183605.5956-1-sds@tycho.nsa.gov>
Subject: [PATCH] selinux: fix missing dput() before selinuxfs unmount
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 0619f0f5e36f ("selinux: wrap selinuxfs state") triggers
a BUG when SELinux is runtime-disabled (i.e. systemd or equivalent
disables SELinux before initial policy load via /sys/fs/selinux/disable
based on /etc/selinux/config SELINUX=disabled).  This does not manifest
if SELinux is disabled via kernel command line argument or if
SELinux is enabled (permissive or enforcing).

Before:
SELinux:  Disabled at runtime.
BUG: Dentry 000000006d77e5c7{i=17,n=null}  still in use (1) [unmount of selinuxfs selinuxfs]

After:
SELinux:  Disabled at runtime.

Fixes: 0619f0f5e36f ("selinux: wrap selinuxfs state")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/selinuxfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4be683eeba01..245160373dab 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2061,6 +2061,7 @@ __initcall(init_sel_fs);
 void exit_sel_fs(void)
 {
 	sysfs_remove_mount_point(fs_kobj, "selinux");
+	dput(selinux_null.dentry);
 	kern_unmount(selinuxfs_mount);
 	unregister_filesystem(&sel_fs_type);
 }
-- 
2.14.3
