From: Andrew Perepechko <anserper@ya.ru>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 sds@tycho.nsa.gov
Cc: Andrew Perepechko <anserper@ya.ru>, andrew.perepechko@seagate.com
Subject: [PATCH v3] selinux: export validatetrans decisions
Date: Thu, 29 Oct 2015 14:01:42 +0300
Message-Id: <1446116502-4233-1-git-send-email-anserper@ya.ru>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Make validatetrans decisions available through selinuxfs.
"/validatetrans" is added to selinuxfs for this purpose.
This functionality is needed by file system servers
implemented in userspace or kernelspace without the VFS
layer.

Writing "$oldcontext $newcontext $tclass $taskcontext"
to /validatetrans is expected to return 0 if the transition
is allowed and -EPERM otherwise.

Signed-off-by: Andrew Perepechko <anserper@ya.ru>
CC: andrew.perepechko@seagate.com
---
 security/selinux/include/classmap.h |  2 +-
 security/selinux/include/security.h |  3 ++
 security/selinux/selinuxfs.c        | 80 +++++++++++++++++++++++++++++++++++++
 security/selinux/ss/services.c      | 34 ++++++++++++----
 4 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 5a4eef5..ef83c4b 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -21,7 +21,7 @@ struct security_class_mapping secclass_map[] = {
 	  { "compute_av", "compute_create", "compute_member",
 	    "check_context", "load_policy", "compute_relabel",
 	    "compute_user", "setenforce", "setbool", "setsecparam",
-	    "setcheckreqprot", "read_policy", NULL } },
+	    "setcheckreqprot", "read_policy", "validate_trans", NULL } },
 	{ "process",
 	  { "fork", "transition", "sigchld", "sigkill",
 	    "sigstop", "signull", "signal", "ptrace", "getsched", "setsched",
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 223e9fd..38feb55 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -187,6 +187,9 @@ int security_node_sid(u16 domain, void *addr, u32 addrlen,
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 				 u16 tclass);
 
+int security_validate_transition_user(u32 oldsid, u32 newsid, u32 tasksid,
+				      u16 tclass);
+
 int security_bounded_transition(u32 oldsid, u32 newsid);
 
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c02da25..0dc407d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -116,6 +116,7 @@ enum sel_inos {
 	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
 	SEL_STATUS,	/* export current status using mmap() */
 	SEL_POLICY,	/* allow userspace to read the in kernel policy */
+	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -653,6 +654,83 @@ static const struct file_operations sel_checkreqprot_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_write_validatetrans(struct file *file,
+					const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	char *oldcon = NULL, *newcon = NULL, *taskcon = NULL;
+	char *req = NULL;
+	u32 osid, nsid, tsid;
+	u16 tclass;
+	int rc;
+
+	rc = task_has_security(current, SECURITY__VALIDATE_TRANS);
+	if (rc)
+		goto out;
+
+	rc = -ENOMEM;
+	if (count >= PAGE_SIZE)
+		goto out;
+
+	/* No partial writes. */
+	rc = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	rc = -ENOMEM;
+	req = kzalloc(count + 1, GFP_KERNEL);
+	if (!req)
+		goto out;
+
+	rc = -EFAULT;
+	if (copy_from_user(req, buf, count))
+		goto out;
+
+	rc = -ENOMEM;
+	oldcon = kzalloc(count + 1, GFP_KERNEL);
+	if (!oldcon)
+		goto out;
+
+	newcon = kzalloc(count + 1, GFP_KERNEL);
+	if (!newcon)
+		goto out;
+
+	taskcon = kzalloc(count + 1, GFP_KERNEL);
+	if (!taskcon)
+		goto out;
+
+	rc = -EINVAL;
+	if (sscanf(req, "%s %s %hu %s", oldcon, newcon, &tclass, taskcon) != 4)
+		goto out;
+
+	rc = security_context_str_to_sid(oldcon, &osid, GFP_KERNEL);
+	if (rc)
+		goto out;
+
+	rc = security_context_str_to_sid(newcon, &nsid, GFP_KERNEL);
+	if (rc)
+		goto out;
+
+	rc = security_context_str_to_sid(taskcon, &tsid, GFP_KERNEL);
+	if (rc)
+		goto out;
+
+	rc = security_validate_transition_user(osid, nsid, tsid, tclass);
+	if (!rc)
+		rc = count;
+out:
+	kfree(req);
+	kfree(oldcon);
+	kfree(newcon);
+	kfree(taskcon);
+	return rc;
+}
+
+static const struct file_operations sel_transition_ops = {
+	.write		= sel_write_validatetrans,
+	.llseek		= generic_file_llseek,
+};
+
 /*
  * Remaining nodes use transaction based IO methods like nfsd/nfsctl.c
  */
@@ -1759,6 +1837,8 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
+		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
+					S_IWUGO},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ebb5eb3..ebda973 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -778,8 +778,8 @@ out:
 	return -EPERM;
 }
 
-int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
-				 u16 orig_tclass)
+static int security_compute_validatetrans(u32 oldsid, u32 newsid, u32 tasksid,
+					  u16 orig_tclass, bool user)
 {
 	struct context *ocontext;
 	struct context *ncontext;
@@ -794,11 +794,12 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 
 	read_lock(&policy_rwlock);
 
-	tclass = unmap_class(orig_tclass);
+	if (!user)
+		tclass = unmap_class(orig_tclass);
+	else
+		tclass = orig_tclass;
 
 	if (!tclass || tclass > policydb.p_classes.nprim) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized class %d\n",
-			__func__, tclass);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -832,8 +833,13 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 	while (constraint) {
 		if (!constraint_expr_eval(ocontext, ncontext, tcontext,
 					  constraint->expr)) {
-			rc = security_validtrans_handle_fail(ocontext, ncontext,
-							     tcontext, tclass);
+			if (user)
+				rc = -EPERM;
+			else
+				rc = security_validtrans_handle_fail(ocontext,
+								     ncontext,
+								     tcontext,
+								     tclass);
 			goto out;
 		}
 		constraint = constraint->next;
@@ -844,6 +850,20 @@ out:
 	return rc;
 }
 
+int security_validate_transition_user(u32 oldsid, u32 newsid, u32 tasksid,
+					u16 tclass)
+{
+	return security_compute_validatetrans(oldsid, newsid, tasksid,
+						tclass, true);
+}
+
+int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
+				 u16 orig_tclass)
+{
+	return security_compute_validatetrans(oldsid, newsid, tasksid,
+						orig_tclass, false);
+}
+
 /*
  * security_bounded_transition - check whether the given
  * transition is directed to bounded, or not.
-- 
1.9.1
