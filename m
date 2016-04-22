Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3MFdCRB004343
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 11:39:12 -0400
Received: by mail-oi0-f51.google.com with SMTP id p188so136859130oih.2
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 08:39:10 -0700 (PDT)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 Miklos Szeredi <mszeredi@redhat.com>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 cgroups@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v3 08/21] userns: Replace in_userns with current_in_userns
Date: Fri, 22 Apr 2016 10:38:25 -0500
Message-Id: <1461339521-123191-9-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1461339521-123191-1-git-send-email-seth.forshee@canonical.com>
References: <1461339521-123191-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

All current callers of in_userns pass current_user_ns as the
first argument. Simplify by replacing in_userns with
current_in_userns which checks whether current_user_ns is in the
namespace supplied as an argument.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 fs/namespace.c                 | 2 +-
 include/linux/user_namespace.h | 6 ++----
 kernel/user_namespace.c        | 6 +++---
 security/commoncap.c           | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6e9db4c166b4..0ad8e4a4f50b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3294,7 +3294,7 @@ bool mnt_may_suid(struct vfsmount *mnt)
 	 * in other namespaces.
 	 */
 	return !(mnt->mnt_flags & MNT_NOSUID) && check_mnt(real_mount(mnt)) &&
-	       in_userns(current_user_ns(), mnt->mnt_sb->s_user_ns);
+	       current_in_userns(mnt->mnt_sb->s_user_ns);
 }
 
 static struct ns_common *mntns_get(struct task_struct *task)
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index a43faa727124..9217169c64cb 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -72,8 +72,7 @@ extern ssize_t proc_projid_map_write(struct file *, const char __user *, size_t,
 extern ssize_t proc_setgroups_write(struct file *, const char __user *, size_t, loff_t *);
 extern int proc_setgroups_show(struct seq_file *m, void *v);
 extern bool userns_may_setgroups(const struct user_namespace *ns);
-extern bool in_userns(const struct user_namespace *ns,
-		      const struct user_namespace *target_ns);
+extern bool current_in_userns(const struct user_namespace *target_ns);
 #else
 
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
@@ -103,8 +102,7 @@ static inline bool userns_may_setgroups(const struct user_namespace *ns)
 	return true;
 }
 
-static inline bool in_userns(const struct user_namespace *ns,
-			     const struct user_namespace *target_ns)
+static inline bool current_in_userns(const struct user_namespace *target_ns)
 {
 	return true;
 }
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index dee3be5445da..68f594212759 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -942,10 +942,10 @@ bool userns_may_setgroups(const struct user_namespace *ns)
  * Returns true if @ns is the same namespace as or a descendant of
  * @target_ns.
  */
-bool in_userns(const struct user_namespace *ns,
-	       const struct user_namespace *target_ns)
+bool current_in_userns(const struct user_namespace *target_ns)
 {
-	for (; ns; ns = ns->parent) {
+	struct user_namespace *ns;
+	for (ns = current_user_ns(); ns; ns = ns->parent) {
 		if (ns == target_ns)
 			return true;
 	}
diff --git a/security/commoncap.c b/security/commoncap.c
index a306c5d90709..e657227d221e 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -461,7 +461,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
 	 * explicit that capability bits are limited to s_user_ns and its
 	 * descendants.
 	 */
-	if (!in_userns(current_user_ns(), bprm->file->f_path.mnt->mnt_sb->s_user_ns))
+	if (!current_in_userns(bprm->file->f_path.mnt->mnt_sb->s_user_ns))
 		return 0;
 
 	rc = get_vfs_caps_from_disk(bprm->file->f_path.dentry, &vcaps);
-- 
1.9.1
