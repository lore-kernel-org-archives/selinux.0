Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8GK3eO4026669
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 16:03:50 -0400
Received: by ioii196 with SMTP id i196so211406ioi.3
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 13:03:49 -0700 (PDT)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v3 4/7] fs: Limit file caps to the user namespace of the super
 block
Date: Wed, 16 Sep 2015 15:02:40 -0500
Message-Id: <1442433764-80826-5-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1442433764-80826-1-git-send-email-seth.forshee@canonical.com>
References: <1442433764-80826-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Capability sets attached to files must be ignored except in the
user namespaces where the mounter is privileged, i.e. s_user_ns
and its descendants. Otherwise a vector exists for gaining
privileges in namespaces where a user is not already privileged.

Add a new helper function, in_user_ns(), to test whether a user
namespace is the same as or a descendant of another namespace.
Use this helper to determine whether a file's capability set
should be applied to the caps constructed during exec.

Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 include/linux/user_namespace.h |  8 ++++++++
 kernel/user_namespace.c        | 14 ++++++++++++++
 security/commoncap.c           |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 8297e5b341d8..a43faa727124 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -72,6 +72,8 @@ extern ssize_t proc_projid_map_write(struct file *, const char __user *, size_t,
 extern ssize_t proc_setgroups_write(struct file *, const char __user *, size_t, loff_t *);
 extern int proc_setgroups_show(struct seq_file *m, void *v);
 extern bool userns_may_setgroups(const struct user_namespace *ns);
+extern bool in_userns(const struct user_namespace *ns,
+		      const struct user_namespace *target_ns);
 #else
 
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
@@ -100,6 +102,12 @@ static inline bool userns_may_setgroups(const struct user_namespace *ns)
 {
 	return true;
 }
+
+static inline bool in_userns(const struct user_namespace *ns,
+			     const struct user_namespace *target_ns)
+{
+	return true;
+}
 #endif
 
 #endif /* _LINUX_USER_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 88fefa68c516..69fbc377357b 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -945,6 +945,20 @@ bool userns_may_setgroups(const struct user_namespace *ns)
 	return allowed;
 }
 
+/*
+ * Returns true if @ns is the same namespace as or a descendant of
+ * @target_ns.
+ */
+bool in_userns(const struct user_namespace *ns,
+	       const struct user_namespace *target_ns)
+{
+	for (; ns; ns = ns->parent) {
+		if (ns == target_ns)
+			return true;
+	}
+	return false;
+}
+
 static inline struct user_namespace *to_user_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct user_namespace, ns);
diff --git a/security/commoncap.c b/security/commoncap.c
index 1832cf701c3d..400aa224b491 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -450,6 +450,8 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
 
 	if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
 		return 0;
+	if (!in_userns(current_user_ns(), bprm->file->f_path.mnt->mnt_sb->s_user_ns))
+		return 0;
 
 	rc = get_vfs_caps_from_disk(bprm->file->f_path.dentry, &vcaps);
 	if (rc < 0) {
-- 
1.9.1
