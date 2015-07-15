Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6FJlHZe029319
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 15:47:20 -0400
Received: by oige126 with SMTP id e126so36027932oig.0
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 12:47:18 -0700 (PDT)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 3/7] fs: Ignore file caps in mounts from other user namespaces
Date: Wed, 15 Jul 2015 14:46:04 -0500
Message-Id: <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
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
index 4109f8320684..2b043876d5f0 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -944,6 +944,20 @@ bool userns_may_setgroups(const struct user_namespace *ns)
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
index d103f5a4043d..175ab497e810 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -439,6 +439,8 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
 
 	if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
 		return 0;
+	if (!in_userns(current_user_ns(), bprm->file->f_path.mnt->mnt_sb->s_user_ns))
+		return 0;
 
 	rc = get_vfs_caps_from_disk(bprm->file->f_path.dentry, &vcaps);
 	if (rc < 0) {
-- 
1.9.1
